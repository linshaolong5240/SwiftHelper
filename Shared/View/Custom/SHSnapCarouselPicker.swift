//
//  SHSnapCarouselPicker.swift
//  SwiftHelper
//
//  Created by sauron on 2022/4/23.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
public enum SHSnapCarouselPickerElementPosition {
    case previous
    case current
    case next
}

public enum SHSnapCarouselPickerScrollDirection {
    case backwark
    case forward
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct SHSnapCarouselPicker<T, Content>: View where T: Equatable,  Content: View {
    @Binding var selection: T
    let data: Array<T>
    let content: (Array<T>.Index, T) -> Content
    
    let widthProportion: CGFloat
    let trailingSpacing: CGFloat
    
    @State private var realIndex: Int
    @State private var currentIndex: Int
    @State private var scrollDirection: SHSnapCarouselPickerScrollDirection = .forward
    @GestureState private var offset: CGFloat = 0
    
    public init(_ data: Array<T>, selection: Binding<T>, widthProportion: CGFloat, trailingSpacing: CGFloat = 0, @ViewBuilder content: @escaping (Array<T>.Index, T) -> Content) {
        self.data = data
        self._selection = selection
        self.content = content
        
        let defaultIndex: Int = data.firstIndex(where: { $0 == selection.wrappedValue }) ?? 0
        self._realIndex = .init(initialValue: defaultIndex)
        self._currentIndex = .init(initialValue: defaultIndex)
        self.trailingSpacing = trailingSpacing
        self.widthProportion = widthProportion
    }
    
    public var body: some View {
        GeometryReader { geometry in
//            let width: CGFloat = geometry.size.width
            let columnWidth: CGFloat = geometry.size.width * widthProportion
            let leadingOffset: CGFloat = (geometry.size.width - columnWidth) / 2
            HStack(spacing: 0) {
                ForEach(Array(zip(data.indices, data)), id: \.0) { index, item in
                    content(index, item)
                        .frame(width: columnWidth)
                }
            }
            .offset(x: leadingOffset + offset + CGFloat(currentIndex) * -columnWidth)
            .gesture(
                DragGesture()
                    .updating($offset) { value, inoutValue, inoutTransaction in
                        inoutValue = value.translation.width
                        #if DEBUG
                        print("inoutValue: \(inoutValue)")
                        #endif
                    }
                    .onChanged { value in
                        let offsetX = -value.translation.width
                        let progress = offsetX / columnWidth
                        let roundeIndex = progress.rounded()
                        realIndex = max(min(currentIndex + Int(roundeIndex), data.count - 1), 0)
                        #if DEBUG
                        print("realIndex: \(realIndex)")
                        #endif
                    }
                    .onEnded { value in
                        currentIndex = realIndex
                        selection = data[currentIndex]
                        #if DEBUG
                        print("currentIndex: \(currentIndex)")
                        #endif
                    }
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }
    
    private func getScale(index: Int, width: CGFloat) -> CGFloat {
        
        func getIndexPosition(index: Int) -> SHSnapCarouselPickerElementPosition? {
            var position: SHSnapCarouselPickerElementPosition? = nil
            if index <= realIndex - 1 {
                position = .previous
            }
            if index == realIndex {
                position = .current
            }
            if index >= realIndex + 1 {
                position =  .next
            }
            return position
        }
        let progress = index == realIndex ? (1 - abs(offset / width)) : abs(offset / width)
        let scale = min(max(progress * 0.5 + 0.5, 0.5), 1.0)
        return scale
    }
}

struct SnapCarouselPickerDemo: View {
    @State private var selection: Color = .blue
    private let colors: [Color] = [.red , .green, .blue, .orange, .pink, .yellow]

    var body: some View {
        VStack {
            selection
                .frame(width: 100, height: 100)
            SHSnapCarouselPicker(colors, selection: $selection, widthProportion: 0.75) { index, item in
                item
                    .overlay(
                        Text("\(index)")
                    )
            }
        }

    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct SHSnapCarouselPicker_Previews: PreviewProvider {
    static var previews: some View {
        SnapCarouselPickerDemo()
    }
}
#endif
