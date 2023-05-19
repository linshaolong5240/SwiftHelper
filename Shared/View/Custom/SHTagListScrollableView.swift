//
//  SHTagListScrollableView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/4/21.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SHTagListScrollableView<Data: RandomAccessCollection,  Content: View>: View where Data.Element: Hashable {
    let data: Data
    let geometry: GeometryProxy
    let HSpacing: CGFloat
    let VSpacing: CGFloat
    let content: (Data.Element) -> Content

    init(_ data: Data, geometry: GeometryProxy, HSpacing: CGFloat = 10, VSpacing: CGFloat = 10, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.geometry = geometry
        self.HSpacing = HSpacing
        self.VSpacing = VSpacing
        self.content = content
    }
    
    var body: some View {
        var width: CGFloat = 0
        var height: CGFloat = 0
        
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
    }
}

struct SHTagListScrollableViewDemo: View {
    private let data = ["Albemarle", "Brandywine", "Chesapeake", "Apple", "Swift", "SwiftUI", "UIKit"]
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                SHTagListScrollableView(data, geometry: geometry) { item in
                    Text(item)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
        }
    }
}

#if DEBUG
struct TagListScrollableView_Previews: PreviewProvider {
    static var previews: some View {
        SHTagListScrollableViewDemo()
    }
}
#endif
