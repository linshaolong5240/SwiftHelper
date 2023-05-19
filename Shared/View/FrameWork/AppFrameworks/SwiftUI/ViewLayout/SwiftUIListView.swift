//
//  SwiftUIListView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/2/22.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUIListView: View {
    @State private var selection = Set<Int>()
    @State private var section0 = Array<Int>(0..<20)
    @State private var section1 = Array<Int>(30..<50)
    #if os(iOS)
    @State private var isEditMode: EditMode = .inactive
    #endif
    
    @State private var searchText: String = ""

        
    var body: some View {
        VStack {
            List(selection: $selection) {
                Section {
                    ForEach(section0, id: \.self) { item in
                        Text("\(item)")
                    }
                    .onDelete { indexSet in
                        deleteRow(indexSet: indexSet)
                    }
                    .onMove{ indexSet, index in
                        moveRow(from: indexSet, to: index)
                    }
                    .listRowBackground(Color.orange)
                    .listRowInsets(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 10))
                } header: {
                    Text("header Section 0")
                } footer: {
                    Text("footer Section 0")
                }

                Section {
                    ForEach(section1, id: \.self) { item in
                        Text("\(item)")
                            .swipeActions {
                                Button {
                                    print("delete")
                                } label: {
                                    Label("Delete", systemImage: "xmark.bin")
                                }
                            }
                    }
                    .listRowBackground(Color.orange)
                    .listRowInsets(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 10))
                } header: {
                    Text("header Section 1")
                } footer: {
                    Text("footer Section 1")
                }
            }
            .searchable(text: $searchText, placement: .automatic, prompt: "Search") {
                Text("A").searchCompletion("AA")
                Text("b")
            }
            .listStyle(.plain)
            //        .listRowSeparator(.hidden)
            .background(.thinMaterial)
            .toolbar {
                #if os(iOS)
                EditButton()
                #endif
            }
            .onAppear {
                #if os(iOS)
                UITableView.appearance().backgroundColor = .clear
                #endif
            }
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        .environment(\.editMode, self.$isEditMode)
        #endif
    }
    
    func deleteRow(indexSet: IndexSet) {
        section0.remove(atOffsets: indexSet)
    }
    
    func moveRow(from: IndexSet, to: Int) {
        section0.move(fromOffsets: from, toOffset: to)
    }
}

struct SwiftUIListView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIListView()
    }
}
