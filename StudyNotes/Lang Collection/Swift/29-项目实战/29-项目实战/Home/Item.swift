//
//  Item.swift
//  29-项目实战
//
//  Created by 朱双泉 on 2019/8/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

struct Item: Convertible {
    let content: String = ""
    let commentsCount: Int = 0
    let lowUrl: String = ""
    let highUrl: String = ""
    let originUrl: String = ""
    let publishedAt: Int = 0
    let user: User! = nil
    let hotComment: Comment? = nil
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
         return property.name.kj.underlineCased()
    }
}
