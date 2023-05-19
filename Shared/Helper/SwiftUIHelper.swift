//
//  SwiftUIHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2021/12/13.
//

import SwiftUI

@available(iOS, introduced: 13.0, deprecated: 100000.0, message: "use `View.alert(title:isPresented:presenting::actions:) instead.")
@available(macOS, introduced: 10.15, deprecated: 100000.0, message: "use `View.alert(title:isPresented:presenting::actions:) instead.")
@available(tvOS, introduced: 13.0, deprecated: 100000.0, message: "use `View.alert(title:isPresented:presenting::actions:) instead.")
@available(watchOS, introduced: 6.0, deprecated: 100000.0, message: "use `View.alert(title:isPresented:presenting::actions:) instead.")
@available(iOSApplicationExtension, unavailable)
extension Alert {
    #if canImport(UIKit)
    public static func systemAuthorization() {
        guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    public static let locationAuthorization: Alert = Alert(title: Text("Location Permissions"), message: Text("Location Authorization Desc"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("Go to Authorization"), action: { systemAuthorization() }))
    public static let photoLibraryAuthorization: Alert = Alert(title: Text("PhotoLibrary Permissions"), message: Text("PhotoLibrary Authorization Desc"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("Go to Authorization"), action: { systemAuthorization() }))
    public static let cameraAuthorization: Alert = Alert(title: Text("Camera Permissions"), message: Text("Camera Authorization Desc"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("Go to Authorization"), action: { systemAuthorization() }))
    #endif
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    //Conditional modifier https://designcode.io/swiftui-handbook-conditional-modifier
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Path {
    public static func RoundedCornersPath(size: CGSize, topLeftRadius: CGFloat = 0, topRightRadius: CGFloat = 0, bottomLeftRadius: CGFloat = 0, bottomRightRadius: CGFloat = 0) -> Path {
        let width = size.width
        let height = size.height
        
        let tl = min(min(topLeftRadius, height / 2), width / 2)
        let tr = min(min(topRightRadius, height / 2), width / 2)
        let bl = min(min(bottomLeftRadius, height / 2), width / 2)
        let br = min(min(bottomRightRadius, height / 2), width / 2)
        
        return Path { path in
            path.move(to: CGPoint(x: width / 2, y: 0))
            path.addLine(to: CGPoint(x: width - tr, y: 0))
            path.addArc(center: CGPoint(x: width - tr, y: tr), radius: tr, startAngle: .degrees(-90), endAngle: .zero, clockwise: false)
            path.addLine(to: CGPoint(x: width, y: height - br))
            path.addArc(center: CGPoint(x: width - br, y: height - br), radius: br, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
            path.addLine(to: CGPoint(x: bl, y: height))
            path.addArc(center: CGPoint(x: bl, y: height - bl), radius: bl, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
            path.addLine(to: CGPoint(x: 0, y: tl))
            path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        }
    }
}

#if canImport(UIKit)
//SwiftUI 隐藏导航栏后返回手势失效问题
//https://stackoverflow.com/questions/59921239/hide-navigation-bar-without-losing-swipe-back-gesture-in-swiftui
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

@available(iOS 13.0, tvOS 13.0, *)
@available(iOSApplicationExtension, unavailable)
extension View {
    //StackNavigationViewStyle
    public func popToRootView() {
        func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
            guard let viewController = viewController else {
                return nil
            }

            if let navigationController = viewController as? UINavigationController {
                return navigationController
            }

            for childViewController in viewController.children {
                return findNavigationController(viewController: childViewController)
            }

            return nil
        }
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popToRootViewController(animated: true)
    }
}

@available(iOS 13.0, tvOS 13.0, *)
@available(iOSApplicationExtension, unavailable)
extension View {
    public func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

