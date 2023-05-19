//
//  SQLiteSwiftDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/6/29.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SQLiteSwiftDemoView: View {
    @State var isInit: Bool = false
    @State var error: SHSQLiteSwiftManagerError?
    @State var items: [SHSQLiteSwiftDemoTable] = []
    
    init() {
        do {
            try SHSQLiteSwiftDemoTable.createTable()
            for i in 1...5 {
                let _ = try SHSQLiteSwiftDemoTable.insert(i: .init(name: "test\(i)", email: "634205468@qq.com\(i)"))
            }
        } catch let error {
            #if DEBUG
            print(error)
            #endif
            self.error = error as? SHSQLiteSwiftManagerError
        }
    }
    
    var body: some View {
        VStack {
            if let e = error {
                Text("error: \(e.localizedDescription)")
            }
            
            HStack {
                Button {
                    do {
                        let _ = try SHSQLiteSwiftDemoTable.insert(i: .init(name: "test\(items.count + 1)", email: "634205468@qq.com\(items.count + 1)"))
                        loadData()
                    } catch let error {
                        #if DEBUG
                        print(error)
                        #endif
                        self.error = error as? SHSQLiteSwiftManagerError
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            List {
                ForEach(items, id: \.name) { item in
                    Text("\(item.id):\(item.name ?? "nil") \(item.email)")
                }
                .onDelete { indexSet in
                    deleteRow(indexSet: indexSet)
                }
            }
        }
        .alert(item: $error, content: { error in
            Alert(title: Text(error.localizedDescription))
        })
        .onAppear {
            loadData()
        }
    }
    
    func loadData() {
        items = try! SHSQLiteSwiftDemoTable.findAll()
    }
    
    func deleteRow(indexSet: IndexSet) {
        if let index = indexSet.first {
            do {
                let _ = try SHSQLiteSwiftDemoTable.delete(i: items[index])
            } catch let e {
                error = e as? SHSQLiteSwiftManagerError
            }
        }
        loadData()
    }
}

#if DEBUG
struct SQLiteSwiftDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SQLiteSwiftDemoView()
    }
}
#endif
