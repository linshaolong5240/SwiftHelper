//
//  SHDashView.swift
//  SwiftHelper
//
//  Created by sauron on 2021/12/4.
//
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct SHDashView<S>: View where S: ShapeStyle {
    private let content: S
    private let style: StrokeStyle
    
    public init(_ content: S, style: StrokeStyle) {
        self.content = content
        self.style = style
    }
    
    public var body: some View {
        GeometryReader { geometry in
            Path { path in
                let size = geometry.frame(in: .local).size
                let p0 = CGPoint(x: 0, y: size.height / 2)
                let p1 = CGPoint(x: size.width, y: size.height / 2)
                path.move(to: p0)
                path.addLine(to: p1)
            }.stroke(content, style: style)
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct DashViewDemoView: View {
    @State private var lineWidth: CGFloat = 10
    @State private var lineCap: CGLineCap = .butt
    @State private var lineJoin: CGLineJoin = .miter
    @State private var dashPhase: CGFloat = 0.0
    @State private var dash0: CGFloat = 5.0
    @State private var dash1: CGFloat = 10.0
    @State private var dash2: CGFloat = 15.0
    @State private var dash3: CGFloat = 20.0

    
    public var body: some View {
        VStack(alignment: .leading) {
            Stepper(value: $lineWidth, in: 1...100) {
                Text("LineWidth: \(Int(lineWidth))")
            }
            Menu("LineCap: \(lineCap)") {
                ForEach(CGLineCap.allCases, id: \.self) { item in
                    Button {
                        print("\(item)")
                        lineCap = item
                    } label: {
                        Text("\(item)")
                    }
                }
            }
            Menu("LineJoin: \(lineJoin)") {
                ForEach(CGLineJoin.allCases, id: \.self) { item in
                    Button {
                        print("\(item)")
                        lineJoin = item
                    } label: {
                        Text("\(item)")
                    }
                }
            }
            Stepper(value: $dashPhase, in: 0...100) {
                Text("DashPhase: \(Int(dashPhase))")
            }
            Stepper(value: $dash0, in: 0...100) {
                Text("Dash 0: \(Int(dash0))")
            }
            Stepper(value: $dash1, in: 0...100) {
                Text("Dash 1: \(Int(dash1))")
            }
            Stepper(value: $dash2, in: 0...100) {
                Text("Dash 2: \(Int(dash2))")
            }
            Stepper(value: $dash3, in: 0...100) {
                Text("Dash 3: \(Int(dash3))")
            }
            SHDashView(Color.accentColor, style: .init(lineWidth: lineWidth, lineCap: lineCap, lineJoin: lineJoin, miterLimit: 10, dash: [dash0, dash1, dash2, dash3], dashPhase: dashPhase))
        }
        .padding()
        #if canImport(UIKit)
        .navigationBarTitle("DashView")
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct DashView_Previews: PreviewProvider {
    static var previews: some View {
        DashViewDemoView()
    }
}
#endif
