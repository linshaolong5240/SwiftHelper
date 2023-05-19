//
//  AppError.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/14.
//

import Foundation

enum AppError: Error, Identifiable {
    var id: String { localizedDescription }
    case error(Error)
}

extension Error {
    func asAppError() -> AppError {
        self as? AppError ?? AppError.error(self)
    }
}


extension AppError {
    var localizedDescription: String {
        switch self {
        case .error(let error): return "\(error.localizedDescription)"
        }
    }
}
