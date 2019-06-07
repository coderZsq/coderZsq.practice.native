//
//  UserData.swift
//  SwiftUI Tutorials
//
//  Created by 朱双泉 on 2019/6/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: BindableObject  {
    let didChange = PassthroughSubject<UserData, Never>()
    
    var showFavoritesOnly = false {
        didSet {
            didChange.send(self)
        }
    }
    
    var landmarks = landmarkData {
        didSet {
            didChange.send(self)
        }
    }
}
