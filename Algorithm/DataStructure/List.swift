//
//  List.swift
//  DataStructure
//
//  Created by 朱双泉 on 08/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class List<Element: Comparable> {
    
    private var capacity: Int  = 0
    private lazy var length: Int = 0
    private lazy var list: [Element] = [Element]()
    
    init(_ listCapacity: Int = 16) {
        capacity = listCapacity
    }
    
    func clear() {
        length = 0
    }
    
    func isEmpty() -> Bool {
        return length == 0 ? true : false
    }
    
    func size() -> Int {
        return length
    }
    
    func getElement(loc index: Int) -> Element? {
        if index < 0 || index >= capacity || length == 0 {
            return nil
        }
        return list[index]
    }
    
    func locateElement(_ element: Element) -> Int {
        for i in 0..<length {
            if list[i] == element {
                return i
            }
        }
        return -1
    }
    
    func prior(of element: Element) -> Element? {
        let temp = locateElement(element)
        if temp == -1 {
            return nil
        } else {
            if temp == 0 {
                return nil
            } else {
                return list[temp - 1]
            }
        }
    }
    
    func next(of element: Element) -> Element? {
        let temp = locateElement(element)
        if temp == -1 {
            return nil
        } else {
            if temp == length - 1 {
                return nil
            } else {
                return list[temp + 1]
            }
        }
    }
    
    @discardableResult func insert(loc index: Int, element: Element) -> Bool {
        if index < 0 || index > length {
            return false
        }
        list.append(element)
        for i in (index..<length).reversed() {
            list[i + 1] = list[i]
        }
        list[index] = element
        length += 1
        return true
    }
    
    @discardableResult func delete(loc index: Int) -> Element? {
        if index < 0 || index >= length {
            return nil
        }
        for i in (index + 1)..<length {
            list[i - 1] = list[i]
        }
        length -= 1
        return list[index]
    }
    
    func traverse() {
        print("︵")
        for i in 0..<length {
            print(list[i])
        }
        print("︶")
    }
}
