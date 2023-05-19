//
//  UIKitViewsAndControlsView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/16.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct UIKitViewsAndControlsView: View {
    var body: some View {
        List {
            Section("Container View") {
                NavigationLink("UICollectionView") {
                    PlatformViewControllerRepresent(UICollectionViewDemoController()).ignoresSafeArea()
                }
                NavigationLink("UITableView") {
                    PlatformViewControllerRepresent(UITableViewDemoController()).ignoresSafeArea()
                }
                NavigationLink("UIScrollView") {
                    PlatformViewControllerRepresent(UIScrollViewDemoController()).ignoresSafeArea()
                }
                NavigationLink("UIStackView") {
                    PlatformViewControllerRepresent(UIStackViewDemoController()).ignoresSafeArea()
                }
            }
            Section("Controls") {
                NavigationLink("UIButton") {
                    PlatformViewControllerRepresent(UIButtonDemoViewController()).ignoresSafeArea()
                }
                NavigationLink("UISegmentedControl") {
                    PlatformViewControllerRepresent(UISegmentedControlDemoViewController()).ignoresSafeArea()
                }
                NavigationLink("UIStepper") {
                    PlatformViewControllerRepresent(UIStepperDemoViewController()).ignoresSafeArea()
                }
                NavigationLink("UISwitch") {
                    PlatformViewControllerRepresent(UISwitchDemoViewController()).ignoresSafeArea()
                }
            }
        }
        .listStyle(.plain)
    }
}

struct UIKitViewsAndControlsView_Previews: PreviewProvider {
    static var previews: some View {
        UIKitViewsAndControlsView()
    }
}
