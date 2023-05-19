//
//  SwiftUIMenusAndCommandsView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/2/21.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUIMenusAndCommandsView: View {
    var body: some View {
        VStack {
            Menu("Options") {
                Button("Order Now", action: placeOrder)
                Button("Adjust Order", action: adjustOrder)
                Button("Cancel", action: cancelOrder)
            } primaryAction: {
                justDoIt()
            }
            
            Menu("Menu") {
                Button("Button 1") {
                    
                }
                Button("Button 2") {
                    
                }
                Button("Button 3") {
                    
                }
                Text("Menu Item 1")
                Text("Menu Item 2")
                Text("Menu Item 3")
            }
        }
    }

    func justDoIt() {
        print("Button was tapped")
    }

    func placeOrder() { }
    func adjustOrder() { }
    func cancelOrder() { }
}

struct SwiftUIMenusAndCommandsView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIMenusAndCommandsView()
    }
}
