//
//  SHPageView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/8/10.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SHPageView<Content, Data>: UIViewControllerRepresentable where Content: View, Data: RandomAccessCollection {
    @Binding var selection: Int
    let data: Data
    let content: (Data.Element) -> Content
    
    private let transitionStyle: UIPageViewController.TransitionStyle
    private let navigationOrientation: UIPageViewController.NavigationOrientation
    
    init(selection: Binding<Int>, data: Data, transitionStyle: UIPageViewController.TransitionStyle = .scroll, navigationOrientation: UIPageViewController.NavigationOrientation = .horizontal, content: @escaping (Data.Element) -> Content) {
        self._selection = selection
        self.data = data
        self.transitionStyle = transitionStyle
        self.navigationOrientation = navigationOrientation
        self.content = content
    }
    
    func makeUIViewController(context: Context) -> SHPageViewController {
        let vc = SHPageViewController(transitionStyle: transitionStyle, navigationOrientation: navigationOrientation)
        vc.isCycleScroll = true
        let vcs = data.map { item in
            UIHostingController(rootView: content(item))
        }
        vc.setControllers(vcs)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SHPageViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = SHPageViewController
    
}

struct SHPageViewDemo: View {
    @State private var selection: Int = 0
    private let data: [Color] = [.red, .green, .blue]

    var body: some View {
        SHPageView(selection: $selection, data: data) { item in
            item
        }
    }
}

#if DEBUG
struct SHPageView_Previews: PreviewProvider {
    static var previews: some View {
        SHPageViewDemo()
    }
}
#endif
