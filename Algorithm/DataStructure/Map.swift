//
//  Map.swift
//  DataStructure
//
//  Created by 朱双泉 on 11/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class Map<Element: Hashable> {
    
    private var capacity: Int
    private var matrix: [Int]
    private lazy var count: Int = 0
    private lazy var map: [Node<Element>] = [Node<Element>]()
    
    init(_ mapCapacity: Int) {
        capacity = mapCapacity
        matrix = [Int](repeating: 0, count: capacity * capacity)
    }
    
    @discardableResult func addNode(_ node: Node<Element>?) -> Bool {
        guard let node = node else { return false }
        map.append(node)
        map[count].data = node.data
        count += 1
        return true
    }
    
    func resetNode() {
        for i in 0..<count {
            map[i].visited = false
        }
    }
    
    @discardableResult func setValueToMatrixForDirectedGraph(row: Int, col: Int, val: Int = 1) -> Bool {
        if row < 0 || row >= capacity {
            return false
        }
        if col < 0 || col >= capacity {
            return false
        }
        matrix[row * capacity + col] = val
        return true
    }
    
    @discardableResult func setValueToMatrixForUndirectedGraph(row: Int, col: Int, val: Int = 1) -> Bool {
        if row < 0 || row >= capacity {
            return false
        }
        if col < 0 || col >= capacity {
            return false
        }
        matrix[row * capacity + col] = val
        matrix[col * capacity + row] = val
        return true
    }
    
    func printMatrix() {
        print("︵")
        for i in 0..<capacity {
            for j in 0..<capacity {
                print(matrix[i * capacity + j], terminator:" ")
            }
            print()
        }
        print("︶")
    }
    
    func depthFirstTraverse(loc index: Int) {
        print("︵")
        func depthFirstTraverseImpl(loc index: Int) {
            guard let data = map[index].data else { return }
            print(data)
            map[index].visited = true
            for i in 0..<capacity {
                let value = getValueFromMatrix(row: index, col: i)
                if value == 1 {
                    if map[i].visited {
                        continue
                    } else {
                        depthFirstTraverseImpl(loc: i)
                    }
                } else {
                    continue
                }
            }
        }
        depthFirstTraverseImpl(loc: index)
        print("︶")
    }
    
    func breadthFirstTraverse(loc index: Int) {
        print("︵")
        guard let data = map[index].data else { return }
        print(data)
        map[index].visited = true
        var temp = [Int]()
        temp.append(index)
        func breadthFirstTraverseImpl(preTemp: [Int]) {
            var temp = [Int]()
            for i in 0..<preTemp.count {
                for j in 0..<capacity {
                    let value = getValueFromMatrix(row: preTemp[i], col: j)
                    if value != 0 {
                        if map[j].visited {
                            continue
                        } else {
                            guard let data = map[j].data else { return }
                            print(data)
                            map[j].visited = true
                            temp.append(j)
                        }
                    }
                }
            }
            if temp.count == 0 {
                return
            } else {
                breadthFirstTraverseImpl(preTemp: temp)
            }
        }
        breadthFirstTraverseImpl(preTemp: temp)
        print("︶")
    }
    
    private func getValueFromMatrix(row: Int, col: Int) -> Int? {
        if row < 0 || row >= capacity {
            return nil
        }
        if col < 0 || col >= capacity {
            return nil
        }
        return matrix[row * capacity + col]
    }
}


