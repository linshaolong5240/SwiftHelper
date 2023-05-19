//
//  AppState.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/14.
//

import SwiftUI

struct AppState {
    var error: AppError?
    var settings = Settings()
    #if os(iOS)
    var widget = Widget()
    #endif
}

extension AppState {
    struct InitStatus {
        @CombineUserStorge(key: .isInit, container: .group)
        var isInit: Bool = false
    }
    struct Settings {
        #if false
        var isFirstLaunch: Bool { get { true } set { }}
        #else
        @CombineUserStorge(key: .isFirstLaunch, container: .group)
        var isFirstLaunch: Bool = true
        #endif
    }
    #if os(iOS)
    struct Widget {
        @CombineUserStorge(key: .isWidgetInit, container: .group)
        var isWidgetInit: Bool = false
        #if canImport(UIKit)
        @CombineUserStorge(key: .widgetTransparentConfiguration, container: .group)
        var transparentCondiguration: SHWidgetTransparentConfiguration = SHWidgetTransparentConfiguration()
        #endif
        @CombineUserStorge(key: .smallWidgetConfiguration, container: .group)
        var smallWidgetConfiguration: [SHWidgetEntry] = []

        @CombineUserStorge(key: .mediumWidgetConfiguration, container: .group)
        var mediumWidgetConfiguration: [SHWidgetEntry] = []
        
        @CombineUserStorge(key: .largeWidgetConfiguration, container: .group)
        var largeWidgetConfiguration: [SHWidgetEntry] = []
    }
    #endif
}
