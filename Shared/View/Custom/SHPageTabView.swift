//
//  SHPageTabView.swift
//  SwiftHelper
//
//  Created by sauron on 2021/12/4.
//

#if canImport(SwiftUI)
import SwiftUI

public struct SHPageTabView<Element, Content>: View where Element: Hashable, Content: View   {
    let data: [Element]
    @Binding var selection: Element
    
    @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    @available(macOS, unavailable)
    var indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .automatic
    let content: (Element) -> Content
    
    @available(macOS 11, *)
    public init(_ data: [Element], selection: Binding<Element>, @ViewBuilder content:  @escaping (Element) -> Content) {
        self.data = data
        self._selection = selection
        self.content = content
    }
    
    @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    @available(macOS, unavailable)
    public init(_ data: [Element], selection: Binding<Element>, indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .automatic, @ViewBuilder content:  @escaping (Element) -> Content) {
        self.data = data
        self._selection = selection
        self.indexDisplayMode = indexDisplayMode
        self.content = content
    }
    
    public var body: some View {
        TabView(selection: $selection) {
            ForEach(data, id: \.self) { element in
                content(element)
            }
        }
#if !os(macOS)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: indexDisplayMode))
#endif
    }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
public struct SHPageTabViewDemoView: View {
    @State var selection: Color = .red

    public var body: some View {
        ZStack {
            selection
            SHPageTabView([.red, .green, .blue], selection: $selection) { item in
                item
            }
            .frame(width: 200, height: 200)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
        .navigationTitle("PageTabView")
#if !os(macOS) && !os(tvOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#if DEBUG
@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
struct PageTabView_Previews: PreviewProvider {
    static var previews: some View {
        SHPageTabViewDemoView()
    }
}
#endif

#endif
