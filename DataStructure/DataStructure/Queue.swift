//
//  Queue.swift
//  DataStructure
//
//  Created by 朱双泉 on 04/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class Queue<T: NSObject> {
    
    private var m_pQueue: [T]
    private lazy var m_iQueueLen: Int = 0
    private var m_iQueueCapacity: Int
    private lazy var m_iHead: Int = 0
    private lazy var m_iTail: Int = 0
    
    init(queueCapacity: Int) {
        m_iQueueCapacity = queueCapacity
        m_pQueue = [T](repeating: T(), count: queueCapacity)
    }
    
    func clearQueue() {
        m_iHead = 0
        m_iTail = 0
        m_iQueueLen = 0
    }
    
    func queueEmpty() -> Bool {
        return m_iQueueLen == 0 ? true : false
    }
    
    func queueFull() -> Bool {
        return m_iQueueLen == m_iQueueCapacity ? true : false
    }
    
    func queueLength() -> Int {
        return m_iQueueLen
    }
    
    
    @discardableResult func enQueue(element: T) -> Bool {
        guard !queueFull() else {return false}
        m_pQueue[m_iTail] = element
        m_iTail += 1
        m_iTail %= m_iQueueCapacity
        m_iQueueLen += 1
        return true
    }
    
    
    @discardableResult func deQueue(element: inout T) -> Bool {
        guard !queueEmpty() else {return false}
        element = m_pQueue[m_iHead]
        m_iHead += 1
        m_iHead %= m_iQueueCapacity
        m_iQueueLen -= 1
        return true
    }
    
    func queueTraverse() {
        for i in m_iHead..<m_iQueueLen + m_iHead {
            print(m_pQueue[i%m_iQueueCapacity])
        }
    }
}
