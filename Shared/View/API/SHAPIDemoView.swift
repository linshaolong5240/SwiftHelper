//
//  SHAPIDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/8/22.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import Combine
import RxSwift

class SHAPIViewModel: ObservableObject {
    var cancells = Set<AnyCancellable>()
    var disposeBag = DisposeBag()
    @Published var ip: String = ""
    @Published var ipInfo: String?
    
    func ipInfoRequestCallback() {
        SH.debug().request(action: SHAPIIPAction(ip: ip.isEmpty ? nil : ip)) { [weak self] result in
            guard let weakSelf = self else {
                return
            }
            switch result {
            case .success(let response):
                weakSelf.ipInfo = response
            case .failure(let error):
                weakSelf.ipInfo = error.localizedDescription
            }
        }
    }
    
    func ipInfoRequestPublisher() {
        SH.debug().requestPublisher(action: SHAPIIPAction(ip: ip.isEmpty ? nil : ip)).sink { completion in
            if case .failure(let error) = completion {
#if DEBUG
                print(error)
#endif
            }
        } receiveValue: { [weak self] response in
            self?.ipInfo = response
        }.store(in: &cancells)
    }
    
#if canImport(RxSwift)
    func ipInfoRequestObservable() {
        SH.debug().requestObservable(action: SHAPIIPAction(ip: ip.isEmpty ? nil : ip)).subscribe(with: self) { owner, response in
            owner.ipInfo = response
        } onFailure: { owner, error in
#if DEBUG
            print(error)
#endif
        } onDisposed: { owner in
            
        }.disposed(by: disposeBag)
    }
#endif
    
    @available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
    func ipInfoRequestAsync() {
        Task {
            let result = await SH.debug().requestAsync(action: SHAPIIPAction(ip: ip.isEmpty ? nil : ip))
            await MainActor.run {
                switch result {
                case .success(let response):
                    ipInfo = response
                case .failure(let error):
                    ipInfo = error.localizedDescription
                }
            }
        }
    }
}

struct SHAPIDemoView: View {
    @ObservedObject private var viewModel = SHAPIViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("IP", text: $viewModel.ip)
            Button {
                viewModel.ipInfoRequestCallback()
            } label: {
                Text("Request Callback")
            }
            
            Button {
                viewModel.ipInfoRequestObservable()
            } label: {
                Text("Request Observable")
            }
            
            Button {
                viewModel.ipInfoRequestPublisher()
            } label: {
                Text("Request Publisher")
            }
            
            if #available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *) {
                Button {
                    viewModel.ipInfoRequestAsync()
                } label: {
                    Text("Request Async")
                }
            }
            
            if let ipInfo = viewModel.ipInfo {
                Text(ipInfo)
            }
        }
    }
}

#if DEBUG
struct SHAPIDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SHAPIDemoView()
    }
}
#endif
