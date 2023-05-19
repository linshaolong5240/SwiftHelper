//
//  SHWidgetFontColorPicker.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/26.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

extension SHWidgetColor {
    static let item0: SHWidgetColor = .init(Color(#colorLiteral(red: 0.9523916841, green: 0.9490478635, blue: 0.9488548636, alpha: 1)))
    static let item1: SHWidgetColor = .init(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
    static let item2: SHWidgetColor = .init(Color(#colorLiteral(red: 1, green: 0.8584260941, blue: 0.3759346902, alpha: 1)))
    static let item3: SHWidgetColor = .init(Color(#colorLiteral(red: 1, green: 0.5847858787, blue: 0.5910910964, alpha: 1)))
    static let item4: SHWidgetColor = .init(Color(#colorLiteral(red: 0.6862745098, green: 0.612534523, blue: 0.9985938668, alpha: 1)))
    static let item5: SHWidgetColor = .init(Color(#colorLiteral(red: 1, green: 0.5937828422, blue: 0.4326036572, alpha: 1)))
}

extension Array where Element == SHWidgetColor {
    static let editItems: [SHWidgetColor] = [.item0, .item1, .item2, .item3, .item4, .item5]
}

struct SHWidgetFontColorPicker: View {
    @Binding var selection: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Font Color")
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ColorPicker("Color Picker", selection: $selection)
                        .labelsHidden()
                        .frame(width: 44, height: 44)
                    ForEach(Array(zip([SHWidgetColor].editItems.indices, [SHWidgetColor].editItems)), id: \.0) { index, item in
                        Button {
                            selection = item.color
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(item.color)
                                .frame(width: 44, height: 44)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black.opacity(index == 0 ? 1 : 0))
                                )
                                .overlay(
                                    VStack {
                                        if item.color == selection {
                                            Image(systemName: "checkmark")
                                        } else {
                                            EmptyView()
                                        }
                                    }
                                )
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#if DEBUG
struct SHWidgetFontColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        SHWidgetFontColorPicker(selection: .constant(.orange))
    }
}
#endif
