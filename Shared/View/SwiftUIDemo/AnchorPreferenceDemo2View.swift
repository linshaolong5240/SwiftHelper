//
//  AnchorPreferenceDemo2View.swift
//  SwiftHelper
//
//  Created by sauron on 2022/5/5.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

fileprivate struct AnchorPreferenceDemo2Data {
    let viewIndex: Int
    var topLeading: Anchor<CGPoint>? = nil
    var bottomTrailing: Anchor<CGPoint>? = nil
}

fileprivate struct AnchorPreferenceDemo2Key: PreferenceKey {
    typealias Value = [AnchorPreferenceDemo2Data]
    
    static var defaultValue: [AnchorPreferenceDemo2Data] = []
    
    static func reduce(value: inout [AnchorPreferenceDemo2Data], nextValue: () -> [AnchorPreferenceDemo2Data]) {
        value.append(contentsOf: nextValue())
    }
}

struct AnchorPreferenceDemo2View: View {
    @State private var activeIdx: Int = 0
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "January", idx: 0)
                MonthView(activeMonth: $activeIdx, label: "February", idx: 1)
                MonthView(activeMonth: $activeIdx, label: "March", idx: 2)
                MonthView(activeMonth: $activeIdx, label: "April", idx: 3)
            }
            
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "May", idx: 4)
                MonthView(activeMonth: $activeIdx, label: "June", idx: 5)
                MonthView(activeMonth: $activeIdx, label: "July", idx: 6)
                MonthView(activeMonth: $activeIdx, label: "August", idx: 7)
            }
            
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "September", idx: 8)
                MonthView(activeMonth: $activeIdx, label: "October", idx: 9)
                MonthView(activeMonth: $activeIdx, label: "November", idx: 10)
                MonthView(activeMonth: $activeIdx, label: "December", idx: 11)
            }
            
            Spacer()
        }.backgroundPreferenceValue(AnchorPreferenceDemo2Key.self) { preferences in
            GeometryReader { geometry in
                self.createBorder(geometry, preferences)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
    
    private func createBorder(_ geometry: GeometryProxy, _ preferences: [AnchorPreferenceDemo2Data]) -> some View {
        let p = preferences.first(where: { $0.viewIndex == self.activeIdx })
        
        let aTopLeading = p?.topLeading
        let aBottomTrailing = p?.bottomTrailing
        
        let topLeading = aTopLeading != nil ? geometry[aTopLeading!] : .zero
        let bottomTrailing = aBottomTrailing != nil ? geometry[aBottomTrailing!] : .zero
        
        
        return RoundedRectangle(cornerRadius: 15)
            .stroke(lineWidth: 3.0)
            .foregroundColor(Color.green)
            .frame(width: bottomTrailing.x - topLeading.x, height: bottomTrailing.y - topLeading.y)
            .fixedSize()
            .offset(x: topLeading.x, y: topLeading.y)
            .animation(.easeInOut(duration: 1.0))
    }
    
    struct MonthView: View {
        @Binding var activeMonth: Int
        let label: String
        let idx: Int
        
        var body: some View {
            Text(label)
                .padding(10)
                .anchorPreference(key: AnchorPreferenceDemo2Key.self, value: .topLeading, transform: { [AnchorPreferenceDemo2Data(viewIndex: self.idx, topLeading: $0)] })
                .transformAnchorPreference(key: AnchorPreferenceDemo2Key.self, value: .bottomTrailing, transform: { ( value: inout [AnchorPreferenceDemo2Data], anchor: Anchor<CGPoint>) in
                    value[0].bottomTrailing = anchor
                })
                .onTapGesture { self.activeMonth = self.idx }
        }
    }
}

#if DEBUG
struct AnchorPreferenceDemo2_Previews: PreviewProvider {
    static var previews: some View {
        AnchorPreferenceDemo2View()
    }
}
#endif
