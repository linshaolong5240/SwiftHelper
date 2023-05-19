//
//  NetworkFrameworkView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/4/8.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import Network

struct NetworkFrameworkView: View {
    @ObservedObject private var model = NetworkPathMonitor()
    
    var body: some View {
        VStack {
            Text("Current path: \(model.currentPath.debugDescription)")
            VStack {
                ForEach(NWInterface.InterfaceType.allCases, id: \.self) { item in
                    HStack {
                        Text("\(item) :")
                            .frame(width: 100, alignment: .leading)
                        Image(systemName: model.currentPath.usesInterfaceType(item) ? "checkmark.circle.fill" : "xmark.circle.fill")
                    }
                }
            }
        }
    }
}

struct NetworkFrameworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkFrameworkView()
    }
}
