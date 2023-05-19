//
//  CrossPlatformHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2021/12/20.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import SwiftUI

#if canImport(AppKit)
import AppKit
public typealias CPColor = NSColor
public typealias CrossImage = NSImage
public typealias CPFont = NSFont
public typealias CPScreen = NSScreen

public typealias CPHostingController = NSHostingController
public typealias CPView = NSView
public typealias CPViewController = NSViewController
public typealias CPViewRepresentable = NSViewRepresentable
public typealias CPViewControllerRepresentable = NSViewControllerRepresentable
#endif

#if canImport(UIKit)
import UIKit
public typealias CPColor = UIColor
public typealias CrossImage = UIImage
public typealias CPFont = UIFont
public typealias CPScreen = UIScreen

public typealias CPHostingController = UIHostingController
public typealias CPView = UIView
public typealias CPViewController = UIViewController
public typealias CPViewRepresentable = UIViewRepresentable
public typealias CPViewControllerRepresentable = UIViewControllerRepresentable
#endif

extension Image {
    public init(crossImage: CrossImage) {
        #if canImport(AppKit)
        self.init(nsImage: crossImage)
        #endif
        #if canImport(UIKit)
        self.init(uiImage: crossImage)
        #endif
    }
}

@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
@available(watchOS, unavailable)
protocol CPViewRepresent: CPViewRepresentable {
#if canImport(AppKit)
    associatedtype ViewType = Self.NSViewType
#endif
#if canImport(UIKit)
    associatedtype ViewType = Self.UIViewType
#endif
    func makeView(context: Self.Context) -> ViewType
    func updateView(view: ViewType, context: Self.Context)
}

extension CPViewRepresent {
#if canImport(AppKit)
    public func makeNSView(context: Context) -> Self.ViewType {
        makeView(context: context)
    }
    
    public func updateNSView(_ nsView: Self.ViewType, context: Context) {
        updateView(view: nsView, context: context)
    }
#endif
    
#if canImport(UIKit)
    public func makeUIView(context: Context) -> Self.ViewType {
        makeView(context: context)
    }
    
    public func updateUIView(_ uiView: Self.ViewType, context: Context) {
        updateView(view: uiView, context: context)
    }
#endif
}

@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
@available(watchOS, unavailable)
public struct PlatformViewRepresent: CPViewRepresent {
    public let view: CPView

    public init(_ view: CPView) {
        self.view = view
    }

    func makeView(context: Context) -> CPView {
        return view
    }

    func updateView(view: CPView, context: Context) {

    }
}

@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
@available(watchOS, unavailable)
protocol CPViewControllerRepresent: CPViewControllerRepresentable {
#if canImport(AppKit)
    associatedtype ViewControllerType = Self.NSViewControllerType
#endif
#if canImport(UIKit)
    associatedtype ViewControllerType = Self.UIViewControllerType
#endif
    func makeViewController(context: Self.Context) -> ViewControllerType
    func updateViewController(_ viewController: ViewControllerType, context: Self.Context)
}

extension CPViewControllerRepresent {
#if canImport(AppKit)
    public func makeNSViewController(context: Context) -> Self.ViewControllerType {
        makeViewController(context: context)
    }
    
    public func updateNSViewController(_ nsViewController: Self.ViewControllerType, context: Context) {
        updateViewController(nsViewController, context: context)
    }
#endif
    
#if canImport(UIKit)
    public func makeUIViewController(context: Context) -> Self.ViewControllerType {
        makeViewController(context: context)
    }
    
    public func updateUIViewController(_ uiViewController: Self.ViewControllerType, context: Context) {
        updateViewController(uiViewController, context: context)
    }
#endif
}

@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
@available(watchOS, unavailable)
public struct PlatformViewControllerRepresent: CPViewControllerRepresent {
    public let viewController: CPViewController

    public init(_ viewController: CPViewController) {
        self.viewController = viewController
    }

    func makeViewController(context: Context) -> CPViewController {
        return viewController
    }

    func updateViewController(_ viewController: CPViewController, context: Context) {

    }
}

//#if canImport(UIKit)
//@available(iOS 13.0, tvOS 13.0, *)
//@available(macOS, unavailable)
//@available(watchOS, unavailable)
//public struct PlatformViewControllerRepresent: UIViewControllerRepresentable {
//    public let viewController: UIViewController
//    
//    public init(_ viewController: UIViewController) {
//        self.viewController = viewController
//    }
//    
//    public func makeUIViewController(context: Context) -> UIViewController {
//        return viewController
//    }
//    
//    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        
//    }
//}
//#endif
