//
//  MetalDepthView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/9.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import MetalKit

struct MetalDepthView: View {
    @State private var top: Float = 0.25
    @State private var left: Float = 0.25
    @State private var right: Float = 0.25

    var body: some View {
        ZStack {
            MetalTrangleDepthView(topDepth: $top, lefDepth: $left, rightDepth: $right)
            VStack {
                Slider(value: $top, in: 0...1) {
                    Text("\(top)")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                }
                .frame(width: 200)
                Spacer()
                HStack {
                    Slider(value: $left, in: 0...1) {
                        Text("\(left)")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("1")
                    }
                    .frame(width: 200)
                    Spacer()
                    Slider(value: $right, in: 0...1) {
                        Text("\(right)")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("1")
                    }
                    .frame(width: 200)
                }
            }
        }
    }
}

struct MetalDepthTestView_Previews: PreviewProvider {
    static var previews: some View {
        MetalDepthView()
    }
}

fileprivate
struct MetalTrangleDepthView: CPViewRepresent {
    @Binding var topDepth: Float
    @Binding var lefDepth: Float
    @Binding var rightDepth: Float
    
    func makeView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.enableSetNeedsDisplay = true
        mtkView.device = MTLCreateSystemDefaultDevice()
        context.coordinator.renderer = MetalDepthRenderer(mtkView: mtkView)
        mtkView.delegate = context.coordinator.renderer
        
        return mtkView
    }
    
    func updateView(view: MTKView, context: Context) {
        context.coordinator.renderer?.topDepth = topDepth
        context.coordinator.renderer?.lefDepth = lefDepth
        context.coordinator.renderer?.rightDepth = rightDepth
        view.needsDisplay = true
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator {
        var renderer: MetalDepthRenderer?
    }
}

