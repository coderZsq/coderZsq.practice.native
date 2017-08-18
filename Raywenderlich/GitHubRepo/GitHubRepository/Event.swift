//
//  Event.swift
//  GitHubRepository
//
//  Created by 双泉 朱 on 17/4/19.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit

typealias AnyDict = [String: Any]

class Event {
    let repo: String
    let name: String
    let imageUrl: URL
    let action: String
    
    init?(dictionary: AnyDict) {
        guard let repoDict = dictionary["repo"] as? AnyDict,
            let actor = dictionary["actor"] as? AnyDict,
            let repoName = repoDict["name"] as? String,
            let actorName = actor["display_login"] as? String,
            let actorUrlString = actor["avatar_url"] as? String,
            let actorUrl  = URL(string: actorUrlString),
            let actionType = dictionary["type"] as? String
            else {
                return nil
        }
        
        repo = repoName
        name = actorName
        imageUrl = actorUrl
        action = actionType
    }
    
    var dictionary: AnyDict {
        return [
            "repo" : ["name": repo],
            "actor": ["display_login": name, "avatar_url": imageUrl.absoluteString],
            "type" : action
        ]
    }
}

