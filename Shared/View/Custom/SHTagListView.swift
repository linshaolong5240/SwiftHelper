//
//  TagList.swift
//  SwiftHelper
//
//  Created by sauron on 2022/4/21.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

//参考 https://stackoverflow.com/questions/62102647/swiftui-hstack-with-wrap-and-dynamic-height
struct SHTagListView<Data: RandomAccessCollection,  Content: View>: View where Data.Element: Hashable {
    let data: Data
    let HSpacing: CGFloat
    let VSpacing: CGFloat
    let content: (Data.Element) -> Content
    @State private var totalHeight = CGFloat.zero
    
    init(_ data: Data, HSpacing: CGFloat = 10, VSpacing: CGFloat = 10, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.HSpacing = HSpacing
        self.VSpacing = VSpacing
        self.content = content
    }
    
    var body: some View {
        var width: CGFloat = .zero
        var height: CGFloat = .zero
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(data, id: \.self) { item in
                    content(item)
                        .alignmentGuide(.leading, computeValue: { dimension in
                            if abs(width + dimension.width) > geometry.size.width {
                                width = 0
                                height += dimension.height + VSpacing
                            }
                            let result = width
                            if item == data.last {
                                width = 0
                            }else {
                                width += dimension.width + HSpacing
                            }
                            return -result
                        })
                        .alignmentGuide(.top, computeValue: { dimension in
                            let result = height
                            if item == data.last {
                                height = 0
                            }
                            return -result
                        })
                }
            }
            .background(viewHeightReader($totalHeight))
        }
        .frame(height: totalHeight)
    }
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct SHTagListViewDemo: View {
    private let data = ["Albemarle", "Brandywine", "Chesapeake", "Apple", "Swift", "SwiftUI", "UIKit"]
    
    var body: some View {
        ScrollView {
            SHTagListView(data) { item in
                Text(item)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        }
    }
}

#if DEBUG
struct TagListView_Previews: PreviewProvider {
    static var previews: some View {
        SHTagListViewDemo()
    }
}
#endif
