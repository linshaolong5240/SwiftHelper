//
//  SHSecondsRefreshTimeView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/12.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct SHSecondsRefreshTimeView: View {
    private let date: Date
    
    public init(_ date: Date) {
        self.date = date
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            if let hour = Calendar.current.dateComponents(in: .current, from: date).hour {
                if hour == 0 {
                    Text("00:")
                }
                if hour > 0 && hour < 10 {
                    Text("0")
                }
            }
            Text(Calendar.current.generateSecondsRefreshTimerDate(date: date), style: .timer)
                .multilineTextAlignment(.center)
        }
    }
    
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct SHSecondsRefreshTime_Previews: PreviewProvider {
    static var previews: some View {
        SHSecondsRefreshTimeView(Date())
            .font(.system(size: 40, weight: .bold).monospacedDigit())
    }
}
#endif
