//
//  SHChartsView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/8/8.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

#if DEBUG
struct SHChartsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            let data: [Double] = [12,11,15,18,22,17,11,12,16,21,24,21,12,11,15]
            let data2: [Double] = [78.0, 54.0, 51.0, 49.0, 49.0, 49.0, 49.0, 47.0, 47.0, 46.0, 46.0, 44.0, 44.0, 44.0, 46.0, 47.0, 49.0, 51.0, 55.0, 57.0, 61.0, 65.0, 69.0, 71.0, 74.0, 72.0, 70.0, 69.0, 67.0, 69.0, 69.0, 67.0, 65.0, 64.0, 62.0, 64.0]
            let data3: [Double] = [5,10,3,8,8,6,2,2,5,10,13,11,5,2,4]
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {
                    SHLineChartView(data, content: Color.orange)
                        .frame(height: 20)
                    SHClosedLineChartView(data2,range: 0...100, content: LinearGradient(gradient: Gradient(colors: [Color.green, Color.green.opacity(0.25)]), startPoint: .top, endPoint: .bottom))
                        .frame(height: 100)
                    SHLineChartView(data3, content: Color.blue)
                        .frame(height: 20)
                        .overlay(
                            SHDotChartView(data3,
                                         content: Circle()
                                            .fill(Color.blue)
                                            .frame(width: 5, height: 5, alignment: .center)
                                            .shadow(color: .blue, radius: 3)
                            )
                        )
                        .padding(.vertical)
                }
                .frame(width: 300)
            }
            Spacer()
        }
    }
}
#endif

struct SHLineChartView<S>: View where S: ShapeStyle {
    private let data: [Double]
    private let content: S
    private let aligementBottom: Bool

    init(_ data: [Double], content: S,  aligementBottom: Bool = false) {
        self.data = data
        self.content = content
        self.aligementBottom = aligementBottom
    }
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Path
                    .LineChart(data: data, aligementBottom: aligementBottom, size: CGSize(width: geometry.size.width, height: geometry.size.height))
                    .stroke(content, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            }
        }
    }
}

struct SHChartsSizePreferenceKey: PreferenceKey {
    typealias Value = CGSize

    static var defaultValue: Value = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        
    }
}

struct SHDotChartView<Content>: View where Content: View {
    
    private let data: [Double]
    private let aligementBottom: Bool
    private let content: Content
    @State private var contentSize: CGSize = .zero
    
    init(_ data: [Double], aligementBottom: Bool = false, content: Content) {
        self.data = data
        self.aligementBottom = aligementBottom
        self.content = content
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
            GeometryReader { geometry in
                //                let width  = geometry.size.width
                let min: CGFloat = aligementBottom ? CGFloat(data.min() ?? 0) : 0
                let max: CGFloat = CGFloat(data.max() ?? 0)
                let delta: CGFloat = CGFloat(max - min)
                let height: CGFloat = geometry.size.height
                let xStep: CGFloat = geometry.size.width / CGFloat(Double(data.count))
                let yStep: CGFloat = geometry.size.height / delta
                let xOffset = -contentSize.width / 2.0
                let yOffset =  -contentSize.height / 2.0
                ForEach(data.indices, id: \.self) { index in
                    content
                        .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(key: SHChartsSizePreferenceKey.self, value: geometry.size)
                                }
                        )
                        .offset(x: CGFloat(index) * xStep, y: height - (CGFloat(data[index]) - min) * yStep)
                        .offset(x: xOffset, y: yOffset)
                }
            }
        }
        .onPreferenceChange(SHChartsSizePreferenceKey.self, perform: { value in
            contentSize = value
        })
    }
}

struct SHClosedLineChartView<S: ShapeStyle>: View {
    private let data: [Double]
    private let range: ClosedRange<Double>?
    private let aligementBottom: Bool
    private let content: S
    
    init(_ data: [Double],
         range: ClosedRange<Double>? = nil,
         aligementBottom: Bool = false,
         content: S) {
        self.data = data
        self.range = range
        self.aligementBottom = aligementBottom
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Path
                    .ClosedLineChart(data: data,range: range, size: CGSize(width: geometry.size.width, height: geometry.size.height))
                    .fill(content)
            }
        }
    }
}

extension Path {
    static public func LineChart(data: [Double], aligementBottom: Bool = false, size: CGSize) -> Path {
        var path = Path()
        guard data.count > 1 else {
            return path
        }
        let min: Double = aligementBottom ? (data.min() ?? 0.0) : 0
        let max: Double = data.max() ?? 0.0
        let delta = max - min
        
        let xStep:CGFloat = size.width / CGFloat(data.count)
        let yStep:CGFloat = size.height / CGFloat(delta)
        path.move(to: CGPoint(x: .zero, y: size.height - CGFloat(data[0] - min) * yStep))
        for index in 1..<data.count {
            path.addLine(to: CGPoint(x: xStep * CGFloat(index), y: size.height - yStep * CGFloat(data[index] - min)))
        }
        return path
    }
    static public func ClosedLineChart(data: [Double],
                                      range: ClosedRange<Double>? = nil,
                                      aligementBottom: Bool = false,
                                      size: CGSize) -> Path {
        var path = Path()
        guard data.count > 1 else {
            return path
        }
        let min: Double = aligementBottom ? (data.min() ?? 0.0) : 0
        var max: Double = data.max() ?? 0.0
        if let range = range {
            max = range.upperBound
        }
        let delta: Double = max - min
        
        let xStep:CGFloat = size.width / CGFloat(data.count)
        let yStep:CGFloat = size.height / CGFloat(delta)
        let p0 = CGPoint(x: .zero, y: size.height - CGFloat(data[0] - min) * yStep)
        path.move(to: p0)
        for index in 1..<data.count {
            path.addLine(to: CGPoint(x: xStep * CGFloat(index), y: size.height - yStep * CGFloat(data[index] - min)))
            if index == (data.count - 1) {
                path.addLine(to: CGPoint(x: xStep * CGFloat(index), y: size.height))
            }
        }
        path.addLine(to: CGPoint(x: .zero, y: size.height))
        path.addLine(to: p0)
        return path
    }
}
