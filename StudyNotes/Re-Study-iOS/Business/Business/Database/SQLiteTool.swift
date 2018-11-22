//
//  SQLiteTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class SQLiteTool: NSObject {
    
    static let shared = SQLiteTool()
    
    lazy var db: OpaquePointer? = {
        guard let docDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else {
            return nil
        }
        let fullPath = docDir + "/demo.sqlite"
        var db = OpaquePointer(bitPattern: 0)
        if sqlite3_open(fullPath, &db) == SQLITE_OK {
            print("打开数据库成功")
        } else {
            print("打开数据库失败")
        }
        return db
    }()
    
    func createTable() -> Bool {
        let sql = "create table if not exists t_student(id integer primary key autoincrement, name text, score real)"
        return exec(sql: sql)
    }
    
    func dropTable() -> Bool {
        let sql = "drop table t_student"
        return exec(sql: sql)
    }
    
    @discardableResult func exec(sql: String) -> Bool {
        return sqlite3_exec(db, sql, nil, nil, nil) == SQLITE_OK
    }
    
    func beginTransaction() {
        exec(sql: "BEGIN TRANSACTION;")
    }
    
    func commitTranscation() {
        exec(sql: "END TRANSACTION;")
    }
    
    func rollbackTranscation() {
        exec(sql: "ROLLBACK;")
    }
}
