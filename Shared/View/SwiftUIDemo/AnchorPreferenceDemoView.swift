//
//  AnchorPreferenceDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/5/5.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

fileprivate struct AnchorPreferenceDemoData {
    let viewIndex: Int
    let bounds: Anchor<CGRect>
}

fileprivate struct AnchorPreferenceDemoKey: PreferenceKey {
    typealias Value = [AnchorPreferenceDemoData]
    
    static var defaultValue: [AnchorPreferenceDemoData] = []
    
    static func reduce(value: inout [AnchorPreferenceDemoData], nextValue: () -> [AnchorPreferenceDemoData]) {
        value.append(contentsOf: nextValue())
    }
}

struct AnchorPreferenceDemoView: View {
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
        }.backgroundPreferenceValue(AnchorPreferenceDemoKey.self) { preferences in
            GeometryReader { geometry in
                self.createBorder(geometry, preferences)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
    
    private func createBorder(_ geometry: GeometryProxy, _ preferences: [AnchorPreferenceDemoData]) -> some View {
        
        let p = preferences.first(where: { $0.viewIndex == self.activeIdx })
        
        let bounds = p != nil ? geometry[p!.bounds] : .zero
                
        return RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3.0)
                .foregroundColor(Color.green)
                .frame(width: bounds.size.width, height: bounds.size.height)
                .fixedSize()
                .offset(x: bounds.minX, y: bounds.minY)
                .animation(.easeInOut(duration: 1.0))
    }
    
    struct MonthView: View {
        @Binding var activeMonth: Int
        let label: String
        let idx: Int
        
        var body: some View {
            Text(label)
                .padding(10)
                .anchorPreference(key: AnchorPreferenceDemoKey.self, value: .bounds, transform: { [AnchorPreferenceDemoData(viewIndex: self.idx, bounds: $0)] })
                .onTapGesture { self.activeMonth = self.idx }
        }
    }
}

#if DEBUG
struct AnchorPreferenceDemo_Previews: PreviewProvider {
    static var previews: some View {
        AnchorPreferenceDemoView()
    }
}
#endif
