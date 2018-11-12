//
//  LoginTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

class LoginTool {

    class func login(account: String, password: String, result: @escaping (_ isSuccess: Bool) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if account == "Castiel" && password == "666" {
                result(true)
            } else {
                result(false)
            }
        }
    }
}
