//
//  SHAPIServer.swift
//  SwiftHelper
//
//  Created by sauron on 2022/8/22.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

public struct SHHTTPMethod: RawRepresentable, Equatable, Hashable {
    public static let get = SHHTTPMethod(rawValue: "GET")
    public static let post = SHHTTPMethod(rawValue: "POST")
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public protocol SHAPIParameters: Codable { }
extension String: SHAPIParameters { }

public struct SHAPIEmptyParameters: SHAPIParameters { }

public protocol SHAPIServerResponse: Codable { }
extension Data: SHAPIServerResponse { }
extension String: SHAPIServerResponse { }

public protocol SHAPIAction {
    associatedtype Parameters: SHAPIParameters
    associatedtype Response: SHAPIServerResponse
    
    var method: SHHTTPMethod { get }
    var host: String { get }
    var uri: String { get }
    var url: String { get }
    var httpHeaders: [String: String]? { get }
    var timeoutInterval: TimeInterval { get }
    
    var parameters: Parameters? { get }
}

public extension SHAPIAction {
    var method: SHHTTPMethod { .get }
    var uri: String { "/" }
    var url: String { host + uri }
    var httpHeaders: [String: String]? { ["Content-Type": "application/json"] }
    var timeoutInterval: TimeInterval { 20 }
    var parameters: SHAPIEmptyParameters? { nil }
}

public let SH = SHAPIServer.shared

public class SHAPIServer {
    public static let shared = SHAPIServer()
    
    private var debug = false
    
    public func debug(_ value: Bool = true) -> Self {
        debug = value
        return self
    }
}

extension SHAPIServer {
    public static func makeRequest<Action: SHAPIAction>(action: Action) -> URLRequest? {
        guard let url: URL = URL(string: action.url), var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        if action.method == .get {
            urlComponents.queryItems = SHURLQueryItemEncoding.default.encode(parameters: action.parameters?.toDictionary())
        }
        //        if let headers = action.httpHeaders {
        //            defaultHttpHeader.merge(headers) { current, new in
        //                new
        //            }
        //        }
        let u = urlComponents.url!
        var request = URLRequest(url: u)
        request.httpMethod = action.method.rawValue
        request.allHTTPHeaderFields = action.httpHeaders
        request.timeoutInterval = action.timeoutInterval
        if action.method == .post {
            request.httpBody =  try? JSONEncoder().encode(action.parameters)
        }
        return request
    }
    
    @discardableResult
    public func request<Action: SHAPIAction>(action: Action, completion: @escaping (Result<Action.Response, Error>) -> Void) -> URLSessionDataTask? {
        let enableDEBUG = debug
        guard let request = Self.makeRequest(action: action) else {
            return nil
        }
        let task = URLSession.shared.dataTask(with: request) { responseData, urlResponse, error in
            if enableDEBUG {
                Self.debugInfo(action: action, data: responseData, urlResponse: urlResponse)
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(error!))
                }
                return
            }
            
            guard let data = responseData, !data.isEmpty else {
                DispatchQueue.main.async {
                    completion(.failure(SHAPIError.noResponseData))
                }
                return
            }
            
            do {
                if Action.Response.self == Data.self {
                    DispatchQueue.main.async {
                        completion(.success(data as! Action.Response))
                    }
                } else if Action.Response.self == String.self {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        DispatchQueue.main.async {
                            completion(.success(jsonString as! Action.Response))
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(.failure(SHAPIError.decodeJSONDataToUTF8StringError))
                        }
                    }
                } else {
                    let model = try JSONDecoder().decode(Action.Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        return task
    }
}

#if canImport(Combine)
import Combine
extension SHAPIServer {
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public func requestPublisher<Action: SHAPIAction>(action: Action) -> AnyPublisher<Action.Response, Error> {
        let enableDEBUG = debug
        guard let request = Self.makeRequest(action: action) else {
            return Fail(error: SHAPIError.makeURLRqeusetError).eraseToAnyPublisher()
        }

        let queue = DispatchQueue(label: "SH API Queue", qos: .default, attributes: .concurrent)
        
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: queue)
            .receive(on: queue)
            .map { data, urlResponse -> Data in
                if enableDEBUG {
                    print(String(data: data, encoding: .utf8) ?? "data is nil")
                }
                return data
            }
        if Action.Response.self == Data.self {
            return publisher
                .map { return $0 as! Action.Response }
                .mapError { error in
                    error
                }
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } else if Action.Response.self == String.self {
            return publisher
                .map { return (String(data: $0, encoding: .utf8) ?? "data is nil") as! Action.Response}
                .mapError { error in
                    error
                }
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } else {
            let decoder = JSONDecoder()
            return publisher
                .decode(type: Action.Response.self, decoder: decoder)
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }
    }
}
#endif

extension SHAPIServer {
    @available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
    public func requestAsync<Action: SHAPIAction>(action: Action) async -> Result<Action.Response, Error> {
        let enableDEBUG = debug
        guard let request = Self.makeRequest(action: action) else {
            return .failure(SHAPIError.makeURLRqeusetError)
        }

        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request, delegate: nil)
            if enableDEBUG {
                Self.debugInfo(action: action, data: data, urlResponse: urlResponse)
            }
            if Action.Response.self == Data.self {
                return .success(data as! Action.Response)
            } else if Action.Response.self == String.self {
                if let jsonString = String(data: data, encoding: .utf8) {
                    return .success(jsonString as! Action.Response)
                } else {
                    return .failure(SHAPIError.decodeJSONDataToUTF8StringError)
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
import RxSwift
extension SHAPIServer {
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public func requestObservable<Action: SHAPIAction>(action: Action) -> Single<Action.Response> {
        let enableDEBUG = debug

        return Single.create { observer in
            guard let request = Self.makeRequest(action: action) else {
                observer(.failure(SHAPIError.makeURLRqeusetError))
                return Disposables.create { }
            }
            let task = URLSession.shared.dataTask(with: request) { responseData, urlResponse, error in
                if enableDEBUG {
                    Self.debugInfo(action: action, data: responseData, urlResponse: urlResponse)
                }
                DispatchQueue.main.async {
                    guard error == nil else {
                        observer(.failure(error!))
                        return
                    }
                    
                    guard let data = responseData, !data.isEmpty else {
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
                                observer(.failure(SHAPIError.decodeJSONDataToUTF8StringError))
                            }
                        } else {
                            let model = try JSONDecoder().decode(Action.Response.self, from: data)
                            observer(.success(model))
                        }
                    } catch let error {
                        observer(.failure(error))
                    }
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
#endif

extension SHAPIServer {
    fileprivate static func debugInfo<Action: SHAPIAction>(action: Action, data: Data?, urlResponse: URLResponse?) {
        print("###SHAPIServer DEBUG info start###")
        print("urlResponse:")
        if let urlResponse = urlResponse {
            print(urlResponse)
        }
        print("parameters:")
        print(action.parameters?.toDictionary() ?? [String: Any]())
        print("response data:")
        if let data = data {
            print(String(data: data, encoding: .utf8) ?? "data is nil")
        } else {
            print("data is nil")
        }
        print("###SHAPIServer DEBUG info end###")
    }
}
