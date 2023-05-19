//
//  WidgetEditView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/9.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import Combine
import WidgetKit

class WidgetEditViewModel: ObservableObject {
    @Published var entry: SHWidgetEntry
    @Published var family: WidgetFamily
    
    //Edit Items
    @Published var background: SHWidgetBackground
    @Published var border: SHWidgetBorder?
    @Published var fontColor: Color
    
    @Published var gifModel: SHGifWidgetConfiguration.GifModel
    @Published var photoModel: SHPhotoWidgetConfiguration.PhotoModel

    init(entry: SHWidgetEntry, family: WidgetFamily) {
        self.entry = entry
        self.family = family
        self.background = entry.theme.background
        self.border = entry.theme.boarder
        self.fontColor = entry.theme.fontColor.color
        
        self.gifModel = entry.resolvedGifModel
        self.photoModel = entry.resolvedPhotoModel
    }
    
    func set(background: SHWidgetBackground) {
        entry.theme.background = background
    }
    
    func set(border: SHWidgetBorder?) {
        entry.theme.boarder = border
    }
    
    func setFontColor(color: Color) {
        entry.theme.fontColor = .init(color)
    }
    
    func setGifModel(_ model: SHGifWidgetConfiguration.GifModel) {
        entry.gifModel = model
    }
    
    func setPhotoModel(_ model: SHPhotoWidgetConfiguration.PhotoModel) {
        entry.photoModel = model
    }
    
    func saveWidget() {
        Store.shared.dispatch(.saveWidget(configuration: entry, family: family))
    }
    
    func updateWidget() {
        Store.shared.dispatch(.updateWidget(configuration: entry, family: family))
    }
    
    func deleteWidget() {
        Store.shared.dispatch(.deleteWidget(configuration: entry, family: family))
    }
}

struct WidgetEditView: View {
    enum SaveMode {
        case save
        case update
    }
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @ObservedObject private var viewModel: WidgetEditViewModel
    private let saveMode: SaveMode
    
    init(configuration: SHWidgetEntry, family: WidgetFamily, saveMode: SaveMode) {
        self.viewModel = WidgetEditViewModel(entry: configuration, family: family)
        self.saveMode = saveMode
    }

    var body: some View {
        VStack {
            SHWidgetEntryParseView(entry: viewModel.entry, family: viewModel.family)
                .modifier(WidgetPreviewModifier(family: viewModel.family))
            ScrollView {
                SHWidgetFontColorPicker(selection: $viewModel.fontColor)
                    .onChange(of: viewModel.fontColor) { newValue in
                        viewModel.setFontColor(color: newValue)
                    }
                SHWidgetBackgroundPicker(selection: $viewModel.background, data: .editItems, family: viewModel.family)
                .onChange(of: viewModel.background) { newValue in
                    viewModel.set(background: newValue)
                }
                
                SHWidgetBorderPicker(selection: $viewModel.border)
                    .onChange(of: viewModel.border) { newValue in
                        viewModel.set(border: newValue)
                    }
                #if canImport(UIKit)
                if viewModel.entry.kind == .gif {
                    SHWidgetGifModelEditer(gifModel: $viewModel.gifModel, family: viewModel.family)
                        .onChange(of: viewModel.gifModel) { newValue in
                            viewModel.setGifModel(newValue)
                        }
                }
                if viewModel.entry.kind == .photo {
                    SHWidgetPhotoModelEditer(photoModel: $viewModel.photoModel, family: viewModel.family)
                        .onChange(of: viewModel.photoModel) { newValue in
                            viewModel.setPhotoModel(newValue)
                        }
                }
                #endif
            }
            Button {
                switch saveMode {
                case .save:
                    viewModel.saveWidget()
                case .update:
                    viewModel.updateWidget()
                }
                presentationMode.wrappedValue.dismiss()
            } label: {
                Capsule()
                    .frame(height: 44)
                    .padding()
                    .overlay(
                        Text("Save")
                            .foregroundColor(.white)
                    )
            }
        }
        .navigationTitle(LocalizedStringKey(viewModel.entry.kind.name))
        #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

struct WidgetEditView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEditView(configuration: .photo_plain, family: .systemSmall, saveMode: .save)
    }
}
