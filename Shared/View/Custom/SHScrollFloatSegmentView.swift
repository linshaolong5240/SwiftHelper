//
//  SHScrollFloatSegmentView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/4/22.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import Combine

//https://stackoverflow.com/questions/65062590/swiftui-detect-when-scrollview-has-finished-scrolling

struct SHScrollFloatSegmentPreferenceData: Equatable {
    let viewIndex: Int
    let rect: CGRect
}

struct SHScrollFloatSegmentPreferenceKey: PreferenceKey {
    typealias Value = [SHScrollFloatSegmentPreferenceData]
    static var defaultValue: [SHScrollFloatSegmentPreferenceData] = []
    
    static func reduce(value: inout [SHScrollFloatSegmentPreferenceData], nextValue: () -> [SHScrollFloatSegmentPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

class SHScrollFloatSegmentViewModel: ObservableObject {
    let onScrollDetector: CurrentValueSubject<SHScrollFloatSegmentPreferenceKey.Value, Never>
    let onScrollEndedPublisher: AnyPublisher<SHScrollFloatSegmentPreferenceKey.Value, Never>

    @Published var showFixedSegment: Bool = false
    @Published var selection: Int = 0
    
    init() {
        let onScrollDetector = CurrentValueSubject<SHScrollFloatSegmentPreferenceKey.Value, Never>([])
        self.onScrollDetector = onScrollDetector
        self.onScrollEndedPublisher = onScrollDetector
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .dropFirst()
            .eraseToAnyPublisher()
    }
}

struct SHScrollFloatSegmentView: View {
    //Must @StateObject
    @StateObject private var viewModel = SHScrollFloatSegmentViewModel()
    private let data: [Color] = [.red, .green, .blue, .yellow, .pink ,.orange, .red, .green, .blue, .yellow, .pink ,.orange, .red, .green, .blue, .yellow, .pink ,.orange]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {
                        Spacer()
                            .frame(height: 200)
                        makeSegmentView(scrillProxy: proxy)
                        .background(SHScrollFloatSegmentPreferenceViewSetter(index: -1))
                        .opacity(viewModel.showFixedSegment ? 0 : 1)
                        ForEach(Array(zip(data.indices, data)), id: \.0) { index, item in
                            item
                                .frame(height: 200)
                                .overlay(Text("\(index)"))
                                .background(SHScrollFloatSegmentPreferenceViewSetter(index: index))
                                .id(item)
                        }
                        .padding(.horizontal)
                    }
                    .onPreferenceChange(SHScrollFloatSegmentPreferenceKey.self) { preference in
                        #if DEBUG
                        print(geometry.frame(in: .named("ScrollFloatSegment")))
                        if let rect = preference.first?.rect {
                            print("first rect:",rect)
                        }
                        let ids = preference.map { $0.viewIndex }
                        print(ids)
                        #endif
                        viewModel.onScrollDetector.send(preference)
                        guard let minY = preference.first?.rect.minY  else {
                            return
                        }
                        checkSelection(geometry: geometry, preference: preference)
                        if minY <= 0 {
                            viewModel.showFixedSegment = true
                        } else {
                            viewModel.showFixedSegment = false
                        }
                    }
                }
                .background(Color.purple)
                .overlay(
                    VStack(alignment: .leading) {
                        makeSegmentView(scrillProxy: proxy)
                        .background(Color.white)
                        .opacity(viewModel.showFixedSegment ? 1 : 0)
                        Color.clear
                    }
                )
                .coordinateSpace(name: "ScrollFloatSegment")
                .onReceive(viewModel.onScrollEndedPublisher) { newValue in
                    #if DEBUG
                    print("onScrollEndedPublisher")
                    #endif
                }
            }
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
    
    func makeSegmentView(scrillProxy: ScrollViewProxy) -> some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(zip(data.indices, data)), id: \.0) { index, item in
                        Button {
                            viewModel.selection = index
                            withAnimation {
                                scrillProxy.scrollTo(item, anchor: .top)
                            }
                        } label: {
                            item
                                .frame(width: 44, height: 44)
                                .border(viewModel.selection == index ? .black : .clear)
                        }
                        .id(index)
                    }
                }
                .padding(.leading)
            }
            .onChange(of: viewModel.selection) { newValue in
                proxy.scrollTo(newValue, anchor: .center)
            }
        }
    }
    
    func checkSelection(geometry: GeometryProxy, preference: SHScrollFloatSegmentPreferenceKey.Value) {
        for p in preference {
            if p.viewIndex >= 0 {
                let delta = p.rect.minY - geometry.frame(in: .named("ScrollFloatSegment")).minY
                if delta > 0 && delta < 50 {
                    viewModel.selection = p.viewIndex
                    #if DEBUG
                    print("viewIndex: \(p.viewIndex), delta: \(delta)")
                    #endif
                }
            }
        }
    }
}

#if DEBUG
struct SHScrollFloatSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        SHScrollFloatSegmentView()
    }
}
#endif

struct SHScrollFloatSegmentPreferenceViewSetter: View {
    let index: Int
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: SHScrollFloatSegmentPreferenceKey.self,
                            value: [SHScrollFloatSegmentPreferenceData(viewIndex: self.index, rect: geometry.frame(in: .named("ScrollFloatSegment")))])
        }
    }
}
