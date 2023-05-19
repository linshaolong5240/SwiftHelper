//
//  NetworkPathMonitor.swift
//  SwiftHelper
//
//  Created by 林少龙 on 2023/4/10.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import Foundation
import Combine
import Network

/// 网络状态检查
final class NetworkPathMonitor: ObservableObject {
    static let shared = NetworkPathMonitor()
    private(set) lazy var currenPathPublisher = makePublisher()
    @Published private(set) var currentPath: NWPath
    @Published private(set) var interfaceType: NWInterface.InterfaceType?
    
    private let monitor: NWPathMonitor
    private lazy var currenPathSubject = CurrentValueSubject<NWPath, Never>(monitor.currentPath)
    
    init() {
        monitor = NWPathMonitor()
        currentPath = monitor.currentPath
        interfaceType = nil
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.currentPath = path
            self?.currenPathSubject.send(path)
            self?.interfaceType = NWInterface.InterfaceType.allCases.filter { path.usesInterfaceType($0) }.first
        }
        monitor.start(queue: DispatchQueue.global())
    }
    
    deinit {
        monitor.cancel()
        currenPathSubject.send(completion: .finished)
    }
    
    private func makePublisher() -> AnyPublisher<NWPath, Never> {
        return currenPathSubject.eraseToAnyPublisher()
    }
}
