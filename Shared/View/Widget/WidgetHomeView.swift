//
//  WidgetHomeView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/8.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

struct WidgetHomeView: View {
    @EnvironmentObject private var store: Store
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @State private var family: WidgetFamily = .systemSmall
    @State private var showMyWidget: Bool = false
    @State private var showWidgetEdit: Bool = false
    @State private var selectedWidget: SHWidgetEntry = .clock_analog_plain
    
    var body: some View {
        ZStack {
            NavigationLink(isActive: $showMyWidget) {
                MyWidgetView(family: $family)
            } label: {
                EmptyView()
            }
            NavigationLink(isActive: $showWidgetEdit) {
                WidgetEditView(configuration: selectedWidget, family: family, saveMode: .save)
            } label: {
                EmptyView()
            }
            VStack {
                WidgetFamilyPicker(selection: $family)
                    .overlay(
                        HStack {
                            Spacer()
                            Button {
                                showMyWidget.toggle()
                            } label: {
                                Text("My Widget")
                            }
                        }
                    )
                    .padding(.horizontal)
                ScrollView {
                    ForEach(SHWidgetCategory.allCases) { item in
                        VStack(alignment: .leading) {
                            Text(LocalizedStringKey(item.name))
                                .padding(.horizontal)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(item.getWidget(family: family)) { widget in
                                        VStack {
                                            SHWidgetEntryParseView(entry: widget, family: family)
                                                .modifier(WidgetPreviewModifier(family: family))
                                            Text(widget.name)
                                        }
                                        .onTapGesture {
                                            selectedWidget = widget
                                            showWidgetEdit.toggle()
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("WidgetKit", displayMode: .inline)
    }
    
    func getPostionItems(family: WidgetFamily) -> [WidgetPosition] {
        switch family {
        case .systemSmall:
            return .smallItems
        case .systemMedium:
            return .mediumItems
        case .systemLarge:
            return .largeItems
        default:
            return []
        }
    }
}

#if DEBUG
struct WidgetHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WidgetHomeView()
                .environmentObject(Store.shared)
        }
    }
}
#endif
