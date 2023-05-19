//
//  SHSQLiteSwiftManager.swift
//  SwiftHelper
//
//  Created by sauron on 2022/6/29.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SQLite
import Alamofire

protocol SHSQLiteSwiftManagerProtocol {
    associatedtype T
    static func createTable() throws -> Void
    static func insert(i: T) throws -> Int64
    static func delete(i: T) throws -> Int
    static func findAll() throws -> [T]
}

extension SHSQLiteSwiftManagerProtocol {
    
}

enum SHSQLiteSwiftManagerError: String, Error, Identifiable {
    var id: String { rawValue }
    
    case connectionError
    case createTableError
    case insertError
    case deleteError
    case updateError
    case dbError
}

struct SHSQLiteSwiftManager {

    static let shared = SHSQLiteSwiftManager()
    let db: Connection?
    
    init() {
        do {
            /// Create an in-memory database
            db = try Connection(.inMemory)
            /// enable statement logging
            db?.trace { print($0) }
        } catch let error {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            db = nil
        }
    }
}

struct SHSQLiteSwiftDemoTable: SHSQLiteSwiftManagerProtocol {
    var id: Int64 = 0
    var name: String?
    var email: String
    
    static let demo = Table("Demo")
    static let id = Expression<Int64>("id")
    static let name = Expression<String?>("name")
    static let email = Expression<String>("email")

    static func createTable() throws {
        guard let db = SHSQLiteSwiftManager.shared.db else {
            throw SHSQLiteSwiftManagerError.connectionError
        }
        
        do {
            try db.run(demo.create(ifNotExists: true, block: { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(email)
            }))
        } catch let error {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            throw error
        }
    }
    
    static func insert(i: Self) throws -> Int64 {
        guard let db = SHSQLiteSwiftManager.shared.db else {
            throw SHSQLiteSwiftManagerError.connectionError
        }
        
        do {
            let insert = demo.insert(name <- i.name, email <- i.email)
            let rowid = try db.run(insert)
            return rowid
        } catch let error {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            throw error
        }
    }
    
    static func delete(i: Self) throws -> Int {
        guard let db = SHSQLiteSwiftManager.shared.db else {
            throw SHSQLiteSwiftManagerError.connectionError
        }
        
        let query = demo.filter(id == i.id)
        do {
            let temp = try db.run(query.delete())
            guard temp == 1 else {
                throw SHSQLiteSwiftManagerError.deleteError
            }
            return temp
        } catch let error {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            throw SHSQLiteSwiftManagerError.dbError
        }
    }
    
    static func update(i: Self) throws {
        guard let db = SHSQLiteSwiftManager.shared.db else {
            throw SHSQLiteSwiftManagerError.connectionError
        }
        
        let query = demo.filter(id == i.id)
        do {
            if try db.run(query.update(name <- i.name, email <- i.email)) > 0 {
                
            } else {
                throw SHSQLiteSwiftManagerError.updateError
            }
        } catch let error {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            throw SHSQLiteSwiftManagerError.dbError
        }
    }
    
    static func findAll() throws -> [Self] {
        guard let db = SHSQLiteSwiftManager.shared.db else {
            throw SHSQLiteSwiftManagerError.connectionError
        }
        
        do {
            var items = [Self]()
            let sequence = try db.prepare(demo)
            for s in sequence {
                items.append(.init(id: s[id], name: s[name], email: s[email]))
            }
            return items
        } catch let error {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            throw error
        }
    }
}
