//
//  MyWidgetView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/10.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit
extension WidgetFamily {
    var sizeForList: CGSize {
        switch self {
        case .systemSmall:      return .init(width: 80, height: 80)
        case .systemMedium:     return .init(width: 80 * 2.1411, height: 80)
        case .systemLarge:      return .init(width: 80 * 0.9528, height: 100)
        case .systemExtraLarge: return .init(width: 80, height: 80)
        @unknown default:       return .init(width: 80, height: 80)
        }
    }
    
    var scalerForList: CGFloat { sizeForList.height / size.height }
}

struct MyWidgetView: View {
    @EnvironmentObject private var store: Store
    
    @Binding var family: WidgetFamily
    
    func getWidgets(family: WidgetFamily) -> [SHWidgetEntry] {
        switch family {
        case .systemSmall:  return store.appState.widget.smallWidgetConfiguration
        case .systemMedium: return store.appState.widget.mediumWidgetConfiguration
        case .systemLarge:  return store.appState.widget.largeWidgetConfiguration
        default: return []
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                let widgets = getWidgets(family: family)
                ForEach(Array(widgets.enumerated()), id: \.offset) { index, item in
                    NavigationLink(destination: WidgetEditView(configuration: item, family: family, saveMode: .update)) {
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(.white)
                            .frame(height: family == .systemLarge ? 132 : 112)
                            .shadow(radius: 10)
                            .overlay(
                                HStack(spacing: 16) {
                                    SHWidgetEntryParseView(entry: item, family: family)
                                        .modifier(WidgetPreviewModifier(family: family))
                                        .scaleEffect(family.scalerForList)
                                        .frame(width: family.sizeForList.width, height: family.sizeForList.height)
                                    VStack(alignment: .leading) {
                                        Text(item.orderName)
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                store.dispatch(.deleteWidget(configuration: item, family: family))
                                            }) {
                                                Image(systemName: "trash")
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                    .padding()
                            )
                            .padding(.horizontal)
                    }
                }
            }
            #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                WidgetFamilyPicker(selection: $family)
            }
        }
    }
}

struct MyWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MyWidgetView(family: .constant(.systemSmall))
        }
        .environmentObject(Store.shared)
    }
}
