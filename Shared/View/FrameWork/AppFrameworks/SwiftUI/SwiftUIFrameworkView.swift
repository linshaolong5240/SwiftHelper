//
//  SwiftUIFrameworkView.swift
//  SwiftHelper
//
//  Created by Saruon on 2022/1/27.
//

import SwiftUI

struct SwiftUIFrameworkView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("SwiftUIDemo") {
                    SwiftUIDemoView()
                }
                Group {
                    Section("Controls") {
                        NavigationLink("Button") {
                            SwiftUIButtonView()
                        }
                        NavigationLink("DisclosureGroup") {
                            DisclosureGroupExampleView()
                        }
                        NavigationLink("Picker") {
                            SwiftUIPickerView()
                        }
                    }
                    Section("File exporter/importer") {
                        NavigationLink("FileExporter") {
                            FileExporterExampleView()
                        }
                        NavigationLink("FileImporter") {
                            FileImporterExampleView()
                        }
                    }
                    Section("On drag/drop") {
                        NavigationLink("OnDrop") {
                            OnDropExampleView()
                        }
                    }
                }
                Section {
                    NavigationLink("Navigation") {
                        SwiftUINavigationView()
                    }
                } header: {
                    Text("App Structure")
                }
                
                Section {
                    NavigationLink("Environment values") {
                        SwiftUIEnvironmentValuesView()
                    }
                } header: {
                    Text("Data and storge")
                }
                
                Section {
                    NavigationLink("Animations") {
                        SwiftUIAnimationsView()
                    }
                    NavigationLink("Text input and output") {
                        SwiftUITextInputAndOutputView()
                    }
                    NavigationLink("Images") {
                        SwiftUIImagesView()
                    }
                    NavigationLink("Menus and commands") {
                        SwiftUIMenusAndCommandsView()
                    }
                } header: {
                    Text("Views")
                }
                
                Section {
                    NavigationLink("List") {
                        SwiftUIListView()
                    }
                } header: {
                    Text("View Layout")
                }
                
                Section {
                    NavigationLink("Technology Specific Views") {
                        TechnologySpecificViews()
                    }
                } header: {
                    Text("Framework Integration")
                }
                
                Section {
                    Group {
                        NavigationLink(destination: SHCalendarViewDemo()) {
                            Text("CalendarView")
                        }
                        NavigationLink {
                            let v = SHLinearGradientCrossView(frame: .zero, start: .top, end: .bottom, colors: [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)], locations: [0.0, 1.0])
                            PlatformViewRepresent(v).ignoresSafeArea()
                        } label: {
                            Text("LinearGradientCrossView")
                        }
                        NavigationLink(destination: SHPageTabViewDemoView()) {
                            Text("PageTabView")
                        }
                    }
                    NavigationLink(destination: DashViewDemoView()) {
                        Text("DashView")
                    }
                    NavigationLink(destination: GradientDemoView()) {
                        Text("LinearGradient")
                    }
                    NavigationLink(destination: SHTagListViewDemo()) {
                        Text("TagListView")
                    }
                    NavigationLink("RollingNumber") {
                        SHRollingNumberDemoView()
                    }
                    NavigationLink(destination: SHRoundedCornersViewDemo()) {
                        Text("RoundedCornersView")
                    }
                    NavigationLink(destination: SHScrollFloatSegmentView()) {
                        Text("ScrollFloatSegmentView")
                    }
    #if canImport(UIKit)
                    NavigationLink {
                        MailViewDemoView()
                    } label: {
                        Text("MailView")
                    }
    #endif
                    NavigationLink(destination: SPSettingView()) {
                        Text("SettingView")
                    }

                } header: {
                    Text("Custom")
                }
    #if canImport(UIKit)
                Section("Widget") {
                    NavigationLink(destination: WidgetHomeView()) {
                        Text("Widget")
                    }
                    NavigationLink(destination: WidgetPreviewDemo()) {
                        Text("WidgetPreviewDemo")
                    }
                    NavigationLink(destination: WidgetSmallPositionView()) {
                        Text("WidgetSmallPositionView")
                    }
                }
    #endif
            }
        }
        .navigationTitle("SwiftUI")
    }
}

#if DEBUG
struct SwiftUIHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SwiftUIFrameworkView()
        }
    }
}
#endif
