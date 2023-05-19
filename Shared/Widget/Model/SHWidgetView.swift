//
//  SHWidgetView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/25.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

protocol SHWidgetView: View {
    associatedtype Configuration: SHWidgetConfiguration
    var configuration: Configuration { get }
    var family: WidgetFamily { get }
    var colorScheme: ColorScheme { get }
}

extension SHWidgetView {
    func widgetStyle<S>(_ style: S) -> some View where S: SHWidgetViewStyle, Self.Configuration == S.Configuration {
        style.makeBody(configuration, family: family, colorScheme: colorScheme)
    }
}

protocol SHWidgetViewStyle {
    associatedtype Body: View
    associatedtype Configuration: SHWidgetConfiguration
    @ViewBuilder func makeBody(_ configuration: Self.Configuration, family: WidgetFamily, colorScheme: ColorScheme) -> Self.Body
}
