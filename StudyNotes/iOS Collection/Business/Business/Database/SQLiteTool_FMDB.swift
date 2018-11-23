//
//  SQLiteTool_FMDB.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class SQLiteTool_FMDB: NSObject {

    static let shared = SQLiteTool_FMDB()
    
    lazy var db: FMDatabase? = {
        guard let docDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else {
            return nil
        }
        let path = docDir + "/demo_fmdb.sqlite"
        let db = FMDatabase(path: path)
        return db
    }()
    
    lazy var dbQueue: FMDatabaseQueue? = {
        guard let docDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else {
            return nil
        }
        let path = docDir + "/demo_fmdbq.sqlite"
        let dbQueue = FMDatabaseQueue(path: path)
        return dbQueue
    }()
    
    override init() {
        super.init()
        if db?.open() ?? false {
            print("打开数据库成功")
        } else {
            print("打开数据库失败")
        }
    }
    
    func createTable() {
        let sql = "create table if not exists t_student(id integer primary key autoincrement, name text not null, score real)"
        dbQueue?.inDatabase({ (db) in
            do {
                try db.executeUpdate(sql, values: nil)
            } catch {
                print(error)
                print("创建表失败")
                return
            }
            print("创建表成功")
        })
    }
    
    func insertStudent() {
        let sql = "insert into t_student(name, score) values('zhangsan', 59.9)"
        dbQueue?.inDatabase({ (db) in
            if db.executeUpdate(sql, withArgumentsIn: []) {
                print("插入成功")
            } else {
                print("插入失败")
            }
        })
    }
    
    func queryAll() {
        let sql = "select * from t_student"
        dbQueue?.inDatabase({ (db) in
            let resultSet = db.executeQuery(sql, withArgumentsIn: [])
            while resultSet?.next() ?? false {
                let name = resultSet?.string(forColumn: "name")
                let score = resultSet?.double(forColumn: "score")
                print(name ?? "", score ?? "")
            }
        })
    }
    
    func transaction() {
        dbQueue?.inTransaction({ (db, rollback) in
            let sql = "insert into t_student(name, score) values('zhangsan', 99)"
            let sql2 = "insert into t_student(name2, score) values('zhangsan', 99)"
            let result1 = db.executeUpdate(sql, withArgumentsIn: [])
            let result2 = db.executeUpdate(sql2, withArgumentsIn: [])
            if result1 && result2 {
                
            } else {
                rollback.pointee = true
            }
        })
    }
}
