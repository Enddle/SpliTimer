//
//  SQLiteHelper.swift
//
//  Created by Enddle Zheng on 5/21/18.
//  Copyright © 2018 Enddle Zheng. All rights reserved.
//

import Foundation
import SQLite3



/**
 SQLite Constants
 */

struct SQLiteConst {
    
    struct Types {
        
        static let text = "TEXT"
        
        static let int = "INTEGER"
    }
}


/**
Open or create a database file and the database.
 
 - returns:
 database: OpaquePointer?
 
 - parameters:
    - name: the file name of database file without extension (.sqlite)
 */

public func openDatabase(_ name: String = "Database") -> OpaquePointer? {
    
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(name).sqlite")
    
    var database: OpaquePointer?
    
    if sqlite3_open(fileURL.path, &database) != SQLITE_OK {
        print("error opening database")
        return nil
    }
    
    return database
}

/**
 Create a table.
 
 - returns:
 isCreated: Bool
 
 - parameters:
    - database: database
    - name:
    - rows:
 */

public func createTable(_ database: OpaquePointer?, name: String, rows: Dictionary<String,String>) -> Bool {
    
    var queryString = "CREATE TABLE IF NOT EXISTS \(name) (id INTEGER PRIMARY KEY AUTOINCREMENT"
    for (rowName, rowType) in rows {
        queryString += ", \(rowName) \(rowType)"
    }
    queryString += ")"
    
    if sqlite3_exec(database, queryString, nil, nil, nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(database)!)
        print("error creating table: \(errmsg)")
        return false
    }
    
    return true
}

/**
 Create tables.
 
 - parameters:
     - database: database
     - tables: <String, Dictionary<String, String>> , for table names and rows (name, type)
 */

public func createTables(_ database: OpaquePointer?, tables: NSDictionary) {
    
    var t = 0
    
    for (table, dic) in tables {
        
        let name = table as! String
        let rows = dic as! Dictionary<String,String>
        t += createTable(database, name: name, rows: rows) ? 1 : 0
    }
    
    print("\(t) of \(tables.count) tables created")
}

/**
 Insert values.
 
 - parameters:
    - database: database
    - table: table name
    - values: Dictionary<String, NSObject> , for value keys and values
 */

public func insertValues(_ database: OpaquePointer?, table: String, values: Dictionary<String, NSObject>) {
    
    // creating a statement
    var statement: OpaquePointer?
    
    // generating insert query string and params array
    var queryRows = ""
    var queryParams = ""
    var params: [NSObject] = []
    for (rowName, value) in values {
        queryRows += queryRows == "" ? "(\(rowName)" : ",\(rowName)"
        queryParams += queryParams == "" ? "(?" : ",?"
        params.append(value)
    }
    queryRows += ")"
    queryParams += ")"
    let queryString = "INSERT INTO \(table) \(queryRows) VALUES \(queryParams)"
    
    // preparing the query
    if sqlite3_prepare(database, queryString, -1, &statement, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(database)!)
        print("error preparing insert: \(errmsg)")
        return
    }
    
    // binding the parameters
    var n: Int32 = 0
    for (i, value) in params.enumerated() {
        n = Int32(i + 1)
        if value is Int {  // Int
            let param = value as! Int32
            if sqlite3_bind_int(statement, n, param) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(database)!)
                print("failure binding name: \(errmsg)")
                return
            }
        } else if value is String {  // String
            let param = value as! String
            if sqlite3_bind_text(statement, n, param, -1, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(database)!)
                print("failure binding name: \(errmsg)")
                return
            }
        } else {  // Unknown Type
            print("failure binding param: \(value), unknown type")
            return
        }
        n += 1
    }
    
    // executing the query to insert values
    if sqlite3_step(statement) != SQLITE_DONE {
        let errmsg = String(cString: sqlite3_errmsg(database)!)
        print("failure inserting valies: \(errmsg)")
        return
    }
    
    print("\(n) of \(values.count) values inserted")
}










