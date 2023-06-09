//
//  Store.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/14.
//

import Foundation
import Combine
import WidgetKit

public class Store: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    public static let shared = Store()
    @Published var appState = AppState()
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[ACTION]: \(action)")
        #endif
        let result = reduce(state: appState, action: action)
        appState = result.0
        if let appCommand = result.1 {
            #if DEBUG
            print("[COMMAND]: \(appCommand)")
            #endif
            appCommand.execute(in: self)
        }
    }
    
    
    func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand? = nil
        switch action {
        case .initAction:
            #if os(iOS)
            if !appState.widget.isWidgetInit {
                appState.widget.isWidgetInit = true
                appState.widget.smallWidgetConfiguration = [.clock_analog_plain]
                appState.widget.mediumWidgetConfiguration = [.clock_analog_plain]
                appState.widget.largeWidgetConfiguration = [.clock_analog_plain]
            }
            #endif
            appCommand = InitActionCommand()
        case .error(let error):
            appState.error = error
        #if os(iOS)
        case .saveWidget(var configuration, let family):
            func getValidConfiguration(configurations: [SHWidgetEntry], configuration: SHWidgetEntry) -> Int {
                let id = configurations.filter({ item in
                    item.kind == configuration.kind
                }).map(\.orderID).max() ?? 0
                return id + 1
            }
            
            setWidgetIntentThumbnail(configuration: &configuration, family: family)
            
            switch family {
            case .systemSmall:
                configuration.orderID = getValidConfiguration(configurations: appState.widget.smallWidgetConfiguration, configuration: configuration)
                appState.widget.smallWidgetConfiguration.insert(configuration, at: 0)
            case .systemMedium:
                configuration.orderID = getValidConfiguration(configurations: appState.widget.mediumWidgetConfiguration, configuration: configuration)
                appState.widget.mediumWidgetConfiguration.insert(configuration, at: 0)
            case .systemLarge:
                configuration.orderID = getValidConfiguration(configurations: appState.widget.largeWidgetConfiguration, configuration: configuration)
                appState.widget.largeWidgetConfiguration.insert(configuration, at: 0)
            default:
                break
            }
        case .updateWidget(var configuration, let family):
            setWidgetIntentThumbnail(configuration: &configuration, family: family)
            switch family {
            case .systemSmall:
                if let index = appState.widget.smallWidgetConfiguration.firstIndex( where: { $0.id == configuration.id } ) {
                    appState.widget.smallWidgetConfiguration[index] = configuration
                    appState.widget.smallWidgetConfiguration.move(fromOffsets: .init(integer: index), toOffset: 0)
                    appCommand = WidgetReloadCommand(kind: SwiftHelperWidgetKind.small.rawValue)
                }
            case .systemMedium:
                if let index = appState.widget.mediumWidgetConfiguration.firstIndex( where: { $0.id == configuration.id } ) {
                    appState.widget.mediumWidgetConfiguration[index] = configuration
                    appState.widget.mediumWidgetConfiguration.move(fromOffsets: .init(integer: index), toOffset: 0)
                    appCommand = WidgetReloadCommand(kind: SwiftHelperWidgetKind.medium.rawValue)
                }
            case .systemLarge:
                if let index = appState.widget.largeWidgetConfiguration.firstIndex( where: { $0.id == configuration.id } ) {
                    appState.widget.largeWidgetConfiguration[index] = configuration
                    appState.widget.largeWidgetConfiguration.move(fromOffsets: .init(integer: index), toOffset: 0)
                    appCommand = WidgetReloadCommand(kind: SwiftHelperWidgetKind.large.rawValue)
                }
            default:
                break
            }
        case .deleteWidget(let widget, let family):
            switch family {
            case .systemSmall:
                if let index = appState.widget.smallWidgetConfiguration.firstIndex( where: { $0.id == widget.id } ) {
                    appState.widget.smallWidgetConfiguration.remove(at: index)
                }
            case .systemMedium:
                if let index = appState.widget.mediumWidgetConfiguration.firstIndex( where: { $0.id == widget.id } ) {
                    appState.widget.mediumWidgetConfiguration.remove(at: index)
                }
            case .systemLarge:
                if let index = appState.widget.largeWidgetConfiguration.firstIndex( where: { $0.id == widget.id } ) {
                    appState.widget.largeWidgetConfiguration.remove(at: index)
                }
            case .systemExtraLarge:
                break
            @unknown default:
                break
            }
        case .reloadWidget(let kind):
            appCommand = WidgetReloadCommand(kind: kind)
        case .setWidgetPostionImageDict(let dict, let colorScheme):
            switch colorScheme {
            case .light:
                appState.widget.transparentCondiguration.lightWidgetPostionImageURLDict = dict
            case .dark:
                appState.widget.transparentCondiguration.darkWidgetPostionImageURLDict = dict
            @unknown default:
                break
//                fatalError()
            }
        case .setWidgetTransparentBackground(let imageURL, let colorScheme):
            switch colorScheme {
            case .light:
                appState.widget.transparentCondiguration.lightImageURL = imageURL
            case .dark:
                appState.widget.transparentCondiguration.darkImageUrl = imageURL
            @unknown default:
                break
//                fatalError()
            }
            
            if let image = imageURL.image {
                appCommand = WidgetPostionImageMakeCommand(image: image, colorScheme: colorScheme)
            }
        #endif
        }
        
        return (appState, appCommand)
    }
}

extension Store {
    #if os(iOS)
    func setWidgetIntentThumbnail(configuration: inout SHWidgetEntry, family: WidgetFamily) {
        guard let thumbnail = SHWidgetEntryParseView(entry: configuration, family: family)
            .modifier(WidgetPreviewModifier(family: family))
            .snapshot()?.resize(to: family.thumbnailSize) else {
            return
        }
        configuration.intentThumbnailURL = try? FileManager.save(image: thumbnail)
    }
    #endif
}
