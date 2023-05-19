//
//  LinearGradientView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/14.
//

import SwiftUI

public class SHLinearGradientCrossView: CPView {
    
    public enum LinearGradientPositon {
        case top
        case bottom
        case left
        case right
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        
        var point: CGPoint {
            switch self {
            case .top:          return CGPoint(x: 0.5, y: 0.0)
            case .bottom:       return CGPoint(x: 0.5, y: 1.0)
            case .left:         return CGPoint(x: 0.0, y: 0.5)
            case .right:        return CGPoint(x: 1.0, y: 0.5)
            case .topLeft:      return CGPoint(x: 0.0, y: 0.0)
            case .topRight:     return CGPoint(x: 1.0, y: 0.0)
            case .bottomLeft:   return CGPoint(x: 0.0, y: 1.0)
            case .bottomRight:  return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    
    lazy private var gradientLayer = CAGradientLayer()

    public init(frame: CGRect, start: LinearGradientPositon, end: LinearGradientPositon, colors: [CPColor], locations: [NSNumber]?) {
        super.init(frame: frame)
        gradientLayer.frame = frame
        gradientLayer.colors = colors.map({ $0.cgColor})
        gradientLayer.locations = locations
        gradientLayer.startPoint = start.point
        gradientLayer.endPoint = end.point
        #if canImport(AppKit)
        layer = gradientLayer
        wantsLayer = true
        #endif
        #if canImport(UIKit)
        layer.insertSublayer(gradientLayer, at:0)
        #endif
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if canImport(UIKit)
    public override func layoutSubviews() {
        gradientLayer.frame = frame
    }
    #endif
}

#if DEBUG
struct SHLinearGradientView_Previews: PreviewProvider {
    static var previews: some View {
        let v = SHLinearGradientCrossView(frame: .zero, start: .top, end: .bottom, colors: [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)], locations: nil)
        PlatformViewRepresent(v)
            .ignoresSafeArea()
    }
}
#endif
