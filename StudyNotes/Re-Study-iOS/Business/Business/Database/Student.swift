//
//  Student.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class Student: NSObject {
    
    var name: String
    var score: Double
    
    let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    override init() {
        name = ""
        score = 0
    }
    
    init(name: String, score: Double) {
        self.name = name
        self.score = score
    }
}

extension Student {
    
    class func queryAllWithStmt() {
        let db = SQLiteTool.shared.db
        let zSql = "select * from t_student"
        var stmt = OpaquePointer(bitPattern: 0)
        if sqlite3_prepare_v2(db, zSql, -1, &stmt, nil) != SQLITE_OK {
            print("预处理语句失败")
            return
        }
        while sqlite3_step(stmt) == SQLITE_ROW {
            let count = sqlite3_column_count(stmt)
            for i in 0..<count {
                let type = sqlite3_column_type(stmt, i)
                if let columnName = sqlite3_column_name(stmt, i) {
                    let columnNameStr = String(cString: columnName)
                    print(columnNameStr)
                }
                if type == SQLITE_INTEGER {
                    let value = sqlite3_column_int(stmt, i)
                    print(value)
                }
                if type == SQLITE_TEXT {
                    if let value = sqlite3_column_text(stmt, i) {
                        let str = String(cString: value)
                        print(str)
                    }
                }
                if type == SQLITE_FLOAT {
                    let value = sqlite3_column_double(stmt, i)
                    print(value)
                }
            }
        }
        sqlite3_finalize(stmt)
    }
    
    class func queryAll() {
        let sql = "select * from t_student"
        let db = SQLiteTool.shared.db
        sqlite3_exec(db, sql, { (firstParam, columnCount, values, columnNames) -> Int32 in
            for i in 0..<Int(columnCount) {
                if
                    let columnName = columnNames?[i],
                    let value = values?[i] {
                    let columnNameStr = String(cString: columnName, encoding: .utf8)
                    let valueStr = String(cString: value, encoding: .utf8)
                    print(columnNameStr ?? "", valueStr ?? "")
                }
            }
            
            return 0
        }, nil, nil)
    }
    
    @discardableResult class func updateStudent(condition: String, whereCondition: String) -> Bool {
        let sql = "update t_student set " + condition + " where " + whereCondition
        return SQLiteTool.shared.exec(sql: sql)
    }
    
    func insertStudent() {
        let sql = "insert into t_student(name, score) values ('\(name)', '\(score)')"
        if SQLiteTool.shared.exec(sql: sql) {
            print("插入成功")
        } else {
            print("插入失败")
        }
    }
    
    func insertWithStmt() {
        let zSql = "insert into t_student(name, score) values (?, ?)"
        let db = SQLiteTool.shared.db
        var stmt = OpaquePointer(bitPattern: 0)
        if sqlite3_prepare_v2(db, zSql, -1, &stmt, nil) == SQLITE_OK {
            print("预处理语句成功")
        } else {
            print("预处理语句失败")
        }
        sqlite3_bind_text(stmt, 1, name, -1, SQLITE_TRANSIENT)
        sqlite3_bind_double(stmt, 2, score)
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("执行预处理语句成功")
        } else{
            print("执行预处理语句失败")
        }
        sqlite3_reset(stmt)
        sqlite3_finalize(stmt)
    }
}
