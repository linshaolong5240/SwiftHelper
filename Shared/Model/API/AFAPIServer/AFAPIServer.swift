//
//  AFAPIServer.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/14.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation
import Alamofire
#if canImport(RxSwift)
import RxSwift
#endif
#if canImport(Combine)
import Combine
#endif

public protocol AFAPIParameters: Codable { }
extension String: AFAPIParameters { }

public struct AFAPIEmptyParameters: AFAPIParameters { }

public protocol AFAPIServerResponse: Codable { }
extension Data: AFAPIServerResponse { }
extension String: AFAPIServerResponse { }

public protocol AFAPIAction {
    associatedtype Parameters: AFAPIParameters
    associatedtype Response: AFAPIServerResponse
    
    var method: HTTPMethod { get }
    var host: String { get }
    var path: String { get }
    var url: String { get }
    var httpHeaders: [String: String]? { get }
    var timeoutInterval: TimeInterval { get }
    
    var parameters: Parameters? { get }
}

public extension AFAPIAction {
    var method: HTTPMethod { .get }
    var path: String { "/" }
    var url: String { host + path }
    var httpHeaders: [String: String]? { ["Content-Type": "application/json"] }
    var headers: HTTPHeaders? {
        guard let headers = httpHeaders else {
            return nil
        }
        
        return HTTPHeaders(headers)
    }
    var timeoutInterval: TimeInterval { 20 }
    var parameters: AFAPIEmptyParameters? { nil }
}

public let AFAPI = AFAPIServer.shared

public class AFAPIServer {
    public static let shared = AFAPIServer()
    private var _debug: Bool = false
    
    public init() { }
    
    public func debug() -> Self {
        _debug = true
        return self
    }
}

extension AFAPIServer {
    @discardableResult
    public func request<Action: AFAPIAction>(action: Action, completion: @escaping (Result<Action.Response, Error>) -> Void) -> DataRequest {
        let request =  AF.request(action.url,
                                 method: action.method,
                                 parameters: action.parameters.toDictionary(),
                                 encoding: action.method == .get ? URLEncoding.default : JSONEncoding.default,
                                  headers: action.headers, requestModifier: { $0.timeoutInterval = action.timeoutInterval })
            .response {[weak self] response in
                if self?._debug ?? false {
                    Self.DEBUGRequest(action: action, response: response)
                }
                
                guard response.error == nil else {
                    completion(.failure(response.error!))
                    return
                }
                
                guard let data = response.data, !data.isEmpty else {
                    completion(.failure(SHAPIError.noResponseData))
                    return
                }
                
                do {
                    if Action.Response.self == Data.self {
                        completion(.success(data as! Action.Response))
                    } else if Action.Response.self == String.self {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            completion(.success(jsonString as! Action.Response))
                        } else {
                            throw SHAPIError.decodeJSONDataToUTF8StringError
                        }
                    } else {
                        let model = try JSONDecoder().decode(Action.Response.self, from: data)
                        completion(.success(model))
                    }
                } catch let error {
                    completion(.failure(error))
                }
            }
        return request
    }
}

#if canImport(Combine)
extension AFAPIServer {
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public func requestPublisher<Action: AFAPIAction>(action: Action) -> Future<Action.Response,Error> {
        return Future<Action.Response,Error> { promise in
            let _ = AF.request(action.url,
                       method: action.method,
                       parameters: action.parameters.toDictionary(),
                       encoding: action.method == .get ? URLEncoding.default : JSONEncoding.default,
                               headers: action.headers, requestModifier: { $0.timeoutInterval = action.timeoutInterval }).response { [weak self] response in
                if self?._debug ?? false {
                    Self.DEBUGRequest(action: action, response: response)
                }
                
                guard response.error == nil else {
                    promise(.failure(response.error!))
                    return
                }
                
                guard let data = response.data, !data.isEmpty else {
                    promise(.failure(SHAPIError.noResponseData))
                    return
                }
                
                do {
                    if Action.Response.self == Data.self {
                        return promise(.success(data as! Action.Response))
                    } else if Action.Response.self == String.self {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            promise(.success(jsonString as! Action.Response))
                            return
                        } else {
                            throw SHAPIError.decodeJSONDataToUTF8StringError
                        }
                    } else {
                        let model = try JSONDecoder().decode(Action.Response.self, from: data)
                        promise(.success(model))
                    }
                } catch let error {
                    promise(.failure(error))
                }
            }
        }
    }
}
#endif

extension AFAPIServer {
    @available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
    public func requestAsync<Action: AFAPIAction>(action: Action) async -> Result<Action.Response, Error> {
        func makeRequest<Action: AFAPIAction>(action: Action) -> URLRequest {
            var request = URLRequest(url: URL(string: action.url)!)
            request.httpMethod = action.method.rawValue
            request.allHTTPHeaderFields = action.httpHeaders
            request.timeoutInterval = action.timeoutInterval
            request.httpBody = action.parameters?.toData()
            return request
        }
        
        let request = makeRequest(action: action)

        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request, delegate: nil)
            if self._debug {
                Self.DEBUGRequest(urlResponse: urlResponse)
            }
            if Action.Response.self == Data.self {
                return .success(data as! Action.Response)
            } else if Action.Response.self == String.self {
                if let jsonString = String(data: data, encoding: .utf8) {
                    return .success(jsonString as! Action.Response)
                } else {
                    throw SHAPIError.decodeJSONDataToUTF8StringError
                }
            } else {
                let model = try JSONDecoder().decode(Action.Response.self, from: data)
                return .success(model)
            }
        } catch let error {
            return .failure(error)
        }
    }
}

#if canImport(RxSwift)
extension AFAPIServer {
    public func requestObservable<Action: AFAPIAction>(action: Action) -> Single<Action.Response> {
        return Single.create { observer in
            let request = AF.request(action.url,
                                     method: action.method,
                                     parameters: action.parameters.toDictionary(),
                                     encoding: action.method == .get ? URLEncoding.default : JSONEncoding.default,
                                     headers: action.headers, requestModifier: { $0.timeoutInterval = action.timeoutInterval })
                .response { response in
                    if self._debug {
                        Self.DEBUGRequest(action: action, response: response)
                    }
                    
                    guard response.error == nil else {
                        observer(.failure(response.error!))
                        return
                    }
                    
                    guard let data = response.data, !data.isEmpty else {
                        observer(.failure(SHAPIError.noResponseData))
                        return
                    }
                    
                    do {
                        if Action.Response.self == Data.self {
                            observer(.success(data as! Action.Response))
                        } else if Action.Response.self == String.self {
                            if let jsonString = String(data: data, encoding: .utf8) {
                                observer(.success(jsonString as! Action.Response))
                            } else {
                                throw SHAPIError.decodeJSONDataToUTF8StringError
                            }
                        } else {
                            let model = try JSONDecoder().decode(Action.Response.self, from: data)
                            observer(.success(model))
                        }
                    } catch let error {
                        observer(.failure(error))
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
#endif

extension AFAPIServer {
    static private func DEBUGRequest(urlResponse: URLResponse) {
        print(urlResponse)
    }
    
    static private func DEBUGRequest<Action: AFAPIAction>(action: Action, response: AFDataResponse<Data?>) {
        print("parameters:")
        print(action.parameters?.toDictionary() ?? [String: Any]())
        print("request:")
        if let request = response.request {
            print(request)
        }
        print("HTTPHeader:")
        if let httpHeader = response.request?.allHTTPHeaderFields {
            print(httpHeader)
        }
        print("HTTPBody:")
        if let httpBody = response.request?.httpBody {
            print(String(data: httpBody, encoding: .utf8) ?? "nil")
        }
        print("response data:")
        if let data = response.data {
            print(data)
            print("response data string:")
            print(String(data: data, encoding: .utf8) ?? "nil")

        }
        print("response error:")
        if let error = response.error {
            print(error)
        }
    }
}
