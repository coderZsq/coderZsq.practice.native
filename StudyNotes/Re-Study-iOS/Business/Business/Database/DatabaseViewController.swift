//
//  DatabaseViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class DatabaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Database"
    }
    
    @IBAction func create_table(_ sender: UIButton) {
        if SQLiteTool.shared.createTable() {
            print("创建表成功")
        } else {
            print("创建表失败")
        }
    }
    
    @IBAction func drop_table(_ sender: UIButton) {
        if SQLiteTool.shared.dropTable() {
            print("删除表成功")
        } else {
            print("删除表失败")
        }
    }
    
    @IBAction func insert_into(_ sender: Any) {
        
        let begin = CFAbsoluteTimeGetCurrent()
        SQLiteTool.shared.beginTransaction()
        for i in 0..<10000 {
            let stu = Student(name: "castiel", score: Double(i))
            stu.insertStudent()
//            stu.insertWithStmt()
        }
        SQLiteTool.shared.commitTranscation()
        let end = CFAbsoluteTimeGetCurrent()
        print(end - begin)
        
    }
    
    @IBAction func update_set(_ sender: UIButton) {
//        if Student.updateStudent(condition: "name = 'aqua'", whereCondition: "score > 100") {
//            print("执行成功")
//        } else {
//            print("执行失败")
//        }
        SQLiteTool.shared.beginTransaction()
        let result1 = Student.updateStudent(condition: "score = score - 5", whereCondition: "name = 'castiel'")
        let result2 = Student.updateStudent(condition: "score = score + 5", whereCondition: "name = 'aqua'")
        if result1 && result2 {
            SQLiteTool.shared.commitTranscation()
        } else {
            SQLiteTool.shared.rollbackTranscation()
        }
    }
    
    @IBAction func select_from(_ sender: UIButton) {
//        Student.queryAll()
        Student.queryAllWithStmt()
    }
}

