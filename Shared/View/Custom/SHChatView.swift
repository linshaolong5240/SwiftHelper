//
//  SHChatView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/4/28.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SHChatView: View {
    enum BubbleType {
        case main
        case other
        
        var rowAlignment: Alignment {
            switch self {
            case .main:    return .trailing
            case .other:     return .leading
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .main:     return .white
            case .other:    return .black
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .main:
                let color = Color(#colorLiteral(red: 0.3958868384, green: 0.7681242824, blue: 0.4075765908, alpha: 1))
                return color
            case .other:
                let color = Color(#colorLiteral(red: 0.9141785502, green: 0.9117427468, blue: 0.9216458201, alpha: 1))
                return color
            }
        }
        
        var backgroundView: some View {
            switch self {
            case .main:
                return RoundedRectangle(cornerRadius: 14)
                    .background(
                        Image(systemName: "triangle.fill")
                            .resizable()
                            .rotationEffect(.degrees(90))
                            .frame(width: 10, height: 10)
                            .offset(x: 5)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    )
                    .foregroundColor(backgroundColor)
            case .other:
                return RoundedRectangle(cornerRadius: 14)
                    .background(
                        Image(systemName: "triangle.fill")
                            .resizable()
                            .rotationEffect(.degrees(-90))
                            .frame(width: 10, height: 10)
                            .offset(x: -5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    )
                    .foregroundColor(backgroundColor)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                makeBubbleRow(text: "as\ndas\ndas\ndsad\nasdasdaasdsad", bubbleType: .main)
                makeBubbleRow(text: "asdasdasdsad", bubbleType: .other)
            }
            .padding()
        }
    }
    
    func makeBubbleRow(text: String, bubbleType: BubbleType) -> some View {
        Text(text)
            .foregroundColor(bubbleType.foregroundColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(bubbleType.backgroundView)
            .frame(maxWidth: .infinity, alignment: bubbleType.rowAlignment)
        
    }
}

#if DEBUG
struct SHChatView_Previews: PreviewProvider {
    static var previews: some View {
        SHChatView()
    }
}
#endif
