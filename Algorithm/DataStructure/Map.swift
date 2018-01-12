//
//  Map.swift
//  DataStructure
//
//  Created by 朱双泉 on 11/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class Map<Element: Hashable> {
    
    class Edge {
        var nodeIndexA: Int
        var nodeIndexB: Int
        var weightValue: Int
        var selected: Bool = false
        
        init(nodeIndexA A: Int = 0, nodeIndexB B: Int = 0, weightValue Val: Int = 0) {
            nodeIndexA = A
            nodeIndexB = B
            weightValue = Val
        }
    }
    
    private var capacity: Int
    private var matrix: [Int]
    private var edge: [Edge]
    private lazy var count: Int = 0
    private lazy var map: [Node<Element>] = [Node<Element>]()
    
    init(_ mapCapacity: Int) {
        capacity = mapCapacity
        matrix = [Int](repeating: 0, count: capacity * capacity)
        edge = [Edge](repeating: Edge(), count: capacity - 1)
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
    
    func primTree(loc index: Int) {
        var edgeCount = 0
        var edgeBuffers = [Edge]()
        var nodeIndexes = [Int]()
        var primTreePath = [Element]()
        
        nodeIndexes.append(index)
        map[index].visited = true
        primTreePath.append(map[index].data!)
        
        while edgeCount < capacity - 1 {
            guard let index: Int = nodeIndexes.last else { continue }
            for i in 0..<capacity {
                guard let value = getValueFromMatrix(row: index, col: i) else { continue }
                if value != 0 {
                    if map[i].visited {
                        continue
                    } else {
                        edgeBuffers.append(Edge(nodeIndexA: index, nodeIndexB: i, weightValue: value))
                    }
                }
            }
            
            let edgeIndex = getMinEdge(buffers: edgeBuffers)
            edgeBuffers[edgeIndex].selected = true
            
            print(edgeBuffers[edgeIndex].nodeIndexA, edgeBuffers[edgeIndex].nodeIndexB, edgeBuffers[edgeIndex].weightValue)
            
            edge[edgeCount] = edgeBuffers[edgeIndex]
            edgeCount += 1
            
            let nextNodeIndex = edgeBuffers[edgeIndex].nodeIndexB
            nodeIndexes.append(nextNodeIndex)
            map[nextNodeIndex].visited = true
            
            primTreePath.append(map[nextNodeIndex].data!)
        }
        for node in primTreePath {
            print("\(node)", terminator: "")
        }
        print()
    }
    
    func kruskalTree() {
        var edgeCount = 0
        var edgeBuffers = [Edge]()
        var nodeIndexes = [[Int]]()
        for i in 0..<capacity {
            for j in i + 1..<capacity {
                guard let value = getValueFromMatrix(row: i, col: j) else { continue }
                if value != 0 {
                    edgeBuffers.append(Edge(nodeIndexA: i, nodeIndexB: j, weightValue: value))
                }
            }
        }
        while edgeCount < capacity - 1 {
            let minEdgeIndex = getMinEdge(buffers: edgeBuffers)
            edgeBuffers[minEdgeIndex].selected = true
            let nodeAIndex = edgeBuffers[minEdgeIndex].nodeIndexA
            let nodeBIndex = edgeBuffers[minEdgeIndex].nodeIndexB
            var nodeAIsInSet = false
            var nodeBIsInSet = false
            var nodeAInSetLabel = -1
            var nodeBInSetLabel = -1
            for i in 0..<nodeIndexes.count {
                nodeAIsInSet = isInSet(nodeIndexes[i], nodeAIndex)
                if nodeAIsInSet {
                    nodeAInSetLabel = i
                }
            }
            for i in 0..<nodeIndexes.count {
                nodeBIsInSet = isInSet(nodeIndexes[i], nodeBIndex)
                if nodeBIsInSet {
                    nodeBInSetLabel = i
                }
            }
            if nodeAInSetLabel == -1 && nodeBInSetLabel == -1 {
                var vec = [Int]()
                vec.append(nodeAIndex)
                vec.append(nodeBIndex)
                nodeIndexes.append(vec)
            } else if nodeAInSetLabel == -1 && nodeAInSetLabel != -1 {
                nodeIndexes[nodeBInSetLabel].append(nodeAIndex)
            } else if nodeAInSetLabel != -1 && nodeAInSetLabel == -1 {
                nodeIndexes[nodeAInSetLabel].append(nodeBIndex)
            } else if nodeAInSetLabel != -1 && nodeBInSetLabel != -1 && nodeAInSetLabel != nodeBInSetLabel {
                nodeIndexes[nodeAInSetLabel] =
                    mergeNodeSets(nodeIndexes[nodeAInSetLabel], nodeIndexes[nodeBInSetLabel])
                for i in nodeBInSetLabel..<nodeIndexes.count-1 {
                    nodeIndexes[i] = nodeIndexes[i + 1]
                }
            } else if nodeAInSetLabel != -1 && nodeBInSetLabel != -1 && nodeAInSetLabel == nodeBInSetLabel {
                continue
            }
            edge[edgeCount] = edgeBuffers[minEdgeIndex]
            edgeCount += 1
            print(edgeBuffers[minEdgeIndex].nodeIndexA, edgeBuffers[minEdgeIndex].nodeIndexB, edgeBuffers[minEdgeIndex].weightValue)
        }
    }
    
    private func getMinEdge(buffers edgeBuffers: [Edge]) -> Int {
        var minWeight = 0
        var edgeIndex = 0
        var i = 0
        for _ in 0..<edgeBuffers.count {
            if !edgeBuffers[i].selected {
                minWeight = edgeBuffers[i].weightValue
                edgeIndex = i
                break
            }
            i += 1
        }
        if minWeight == 0 {
            return -1;
        }

        for _ in i..<edgeBuffers.count {
            if edgeBuffers[i].selected {
                i += 1
                continue
            } else {
                if minWeight > edgeBuffers[i].weightValue {
                    minWeight = edgeBuffers[i].weightValue
                    edgeIndex = i
                }
            }
            i += 1
        }
        return edgeIndex
    }
    
    private func isInSet(_ nodeSet:[Int], _ target: Int) -> Bool {
        for i in 0..<nodeSet.count {
            if nodeSet[i] == target {
                return true
            }
        }
        return false
    }
    
    private func mergeNodeSets(_ nodeSetA: [Int], _ nodeSetB: [Int]) -> [Int] {
        var nodeSet = [Int]()
        for i in 0..<nodeSetB.count {
            nodeSet.append(nodeSetB[i])
        }
        return nodeSet
    }
}
