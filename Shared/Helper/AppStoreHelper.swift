//
//  AppStoreHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/18.
//

#if canImport(UIKit)
import Foundation
import Alamofire
import StoreKit

public struct AppStoreHelper {
    public static func checkRiviewStatus(localVersion: String, appStoreVersion: String) -> Bool {
        //不明确的情况保险处理
        guard appStoreVersion.count > 0, localVersion.count > 0
        else { return true }
        
        guard appStoreVersion.count == localVersion.count
        else { return true }
        
        let storeArray = appStoreVersion.components(separatedBy: ".")
        let appArray = localVersion.components(separatedBy: ".")
        
        let smallCount = (storeArray.count > appArray.count) ? appArray.count : storeArray.count
        
        for i in 0..<smallCount {
            guard let storeValue: Int = Int(storeArray[i]),
                  let appValue: Int = Int(appArray[i])
            else { return true }
            
            if storeValue > appValue {
                return false
            } else if storeValue < appValue {
                return true
            }
        }
        
        if appArray.count == storeArray.count {
            return false
        } else {
            return true
        }
    }
    
    public static func requestAppStoreVersion(appId: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        var request = URLRequest(url: URL(string: "https://itunes.apple.com/lookup?id=\(appId)")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = TimeInterval(10)
        
        AF.request(request).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.value as? [String: Any],
                   let results = value["results"] as? NSArray,
                   results.count > 0, let resultDic = results[0] as? NSDictionary,
                   let version = resultDic.object(forKey: "version") as? String {
                    completionHandler(.success(version))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    public static func checkAppRiviewStatus(appId: String, localVersion: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        requestAppStoreVersion(appId: appId) { result in
            switch result {
            case .success(let version):
                completionHandler(.success(checkRiviewStatus(localVersion: localVersion, appStoreVersion: version)))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    static func showAppStoreWith(_ appID: String, parent: UIViewController? = UIApplication.rootViewController) {
        let vc = SKStoreProductViewController()
        let parameters = [SKStoreProductParameterITunesItemIdentifier: appID]
        vc.loadProduct(withParameters: parameters)

        parent?.present(vc, animated: true, completion: nil)
    }
    
    static func rateApp() {
        if #available(iOS 14.0, *) {
            if let windowScene = UIApplication.shared.windows.first?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        } else {
            // Fallback on earlier versions
            SKStoreReviewController.requestReview()
        }
    }
}
#endif
