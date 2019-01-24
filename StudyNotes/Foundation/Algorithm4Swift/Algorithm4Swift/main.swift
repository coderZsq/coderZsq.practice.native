//
//  main.swift
//  DataStructure
//
//  Created by 朱双泉 on 05/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

var bits = BitSet(size: 140)

public func scope(of description: String, execute: Bool, action: () -> ()) {
    guard execute else { return }
    print("--- scope of:", description, "---")
    action()
}

scope(of: "queue", execute: true) {
    
    let queue_i = Queue_<Int>()
    queue_i.entry(1)
    queue_i.entry(2)
    queue_i.entry(3)
    queue_i.traverse()
    
    print(queue_i.depart()!)
    queue_i.traverse()
    
    print(queue_i.depart()!)
    queue_i.traverse()
    
    queue_i.entry(4)
    queue_i.entry(5)
    queue_i.traverse()
    
    print(queue_i.depart()!)
    queue_i.traverse()
    
    let queue_s = Queue_<String>(5)
    queue_s.entry("one")
    queue_s.entry("two")
    queue_s.entry("three")
    queue_s.entry("four")
    queue_s.entry("five")
    queue_s.entry("six")
    queue_s.entry("seven")
    queue_s.entry("eight")
    queue_s.entry("nine")
    queue_s.traverse()
    
    print(queue_s.depart()!)
    print(queue_s.depart()!)
    print(queue_s.depart()!)
    queue_s.entry("ten")
    queue_s.traverse()
}

scope(of: "stack", execute: true) {
    
    let stack_i = Stack_<Int>(3)
    stack_i.push(1)
    stack_i.push(2)
    stack_i.push(3)
    stack_i.push(4)
    stack_i.traverse()

    print(stack_i.pop()!)
    stack_i.traverse()

    stack_i.push(5)
    stack_i.push(6)
    stack_i.traverse()

    print(stack_i.pop()!)
    stack_i.traverse()

    let stack_s = Stack_<String>()
    stack_s.push("one")
    stack_s.push("two")
    stack_s.push("three")
    stack_s.traverse()

    stack_s.pop()
    stack_s.pop()
    stack_s.pop()
    stack_s.pop()
    stack_s.traverse()

    func converse(_ origin: Int , format: Int) -> String {
        let stack = Stack_<Int>(30)
        var ori = origin
        var mod = 0
        var char = ["0","1","2","3","4","5","6","7","8","9",
                    "A","B","C","D","E","F"]
        var conversed = ""
        while ori != 0 {
            mod = ori % format
            stack.push(mod)
            ori /= format
        }
        while !stack.isEmpty() {
            guard let index = stack.pop() else { continue }
            conversed += char[index]
        }
        stack.clear()
        return "(\(conversed))"
    }
    print(converse(1000, format: 2))
    print(converse(1000, format: 8))
    print(converse(1000, format: 10))
    print(converse(123456789, format: 16))

    func match(_ brackets: String) -> Bool {
        let stack = Stack_<Character>(30)
        let needStack = Stack_<Character>(30)
        var currentNeed = Character(" ")
        for i in 0..<brackets.count {
            let char = brackets[brackets.index(brackets.startIndex, offsetBy: i)]
            if  char != currentNeed {
                stack.push(char)
                switch char {
                case "[":
                    if currentNeed != Character(" ") {
                        needStack.push(currentNeed)
                    }
                    currentNeed = "]"
                    break
                case "(":
                    if currentNeed != Character(" ") {
                        needStack.push(currentNeed)
                    }
                    currentNeed = ")"
                    break
                default:
                    return false
                }
            } else {
                stack.pop()
                guard let need = needStack.pop() else { currentNeed = Character(" "); continue }
                currentNeed = need
            }
        }
        return stack.isEmpty()
    }
    print(match("[]()[]()[]") ? "match" : "not match")
}

scope(of: "list", execute: true) {
    
    scope(of: "array-list", execute: true, action: {
        
        let list_i = List1<Int>(10)
        list_i.insert(loc: 0, element: 1)
        list_i.insert(loc: 1, element: 2)
        list_i.insert(loc: 2, element: 3)
        list_i.insert(loc: 3, element: 4)
        list_i.insert(loc: 4, element: 5)
        list_i.insert(loc: 5, element: 6)
        list_i.insert(loc: 6, element: 7)
        list_i.traverse()
        
        list_i.delete(loc: 3)
        list_i.delete(loc: 2)
        list_i.traverse()
        
        print(list_i.prior(of: 6)!)
        print(list_i.next(of: 1)!)
        print(list_i.getElement(loc: 2)!)
        
        let list_s = List1<String>()
        list_s.insert(loc: 0, element: "one")
        list_s.insert(loc: 1, element: "two")
        list_s.insert(loc: 2, element: "three")
        list_s.insert(loc: 3, element: "four")
        list_s.insert(loc: 4, element: "five")
        list_s.insert(loc: 5, element: "six")
        list_s.insert(loc: 6, element: "seven")
        list_s.traverse()
        
        list_s.delete(loc: 2)
        list_s.delete(loc: 5)
        list_s.traverse()
        
        print(list_s.prior(of: "two")!)
        print(list_s.next(of: "five")!)
        print(list_s.getElement(loc: 3)!)
    })
    
    scope(of: "link-list", execute: true) {
        
        let list_i = List2<Int>()
        for i in 1...7 {
            list_i.insertTail(node: Node<Int>(data: i))
        }
        list_i.traverse()
        
        list_i.getElement(loc: 2)?.printNode()
        
        let node_i = Node<Int>(data: 1024)
        list_i.insert(loc: 5, node: node_i)
        list_i.traverse()
        
        print(list_i.locate(of: node_i))
        print(list_i.size())
        
        list_i.prior(of: node_i)?.printNode()
        list_i.next(of: node_i)?.printNode()
        list_i.delete(loc: 5)?.printNode()
        
        list_i.traverse()
        
        let list_s = List2<String>()
        let alphabet = "ABCDEFG"
        for i in alphabet {
            list_s.insertHead(node: Node<String>(data: String(i)))
        }
        list_s.traverse()
        
        list_s.getElement(loc: 6)?.printNode()
        
        let node_s = Node<String>(data: "Castie!")
        list_s.insert(loc: 3, node: node_s)
        list_s.getElement(loc: 3)?.printNode()
        
        list_s.traverse()
        
        list_s.prior(of: node_s)?.printNode()
        list_s.next(of: node_s)?.printNode()
    }
}

scope(of: "tree", execute: true) {
    
    scope(of: "array-tree", execute: true, action: {
        
        let tree_i = Tree1(15, root: Node<Int>(data: 3))
        tree_i.addNode(loc: 0, direction: .right, node: Node<Int>(data: 4))
        tree_i.addNode(loc: 2, direction: .left, node: Node<Int>(data: 5))
        tree_i.addNode(loc: 5, direction: .right, node: Node<Int>(data: 6))
        
        tree_i.traverse()
        
        tree_i.searchNode(loc: 5)?.printNode()
        tree_i.deleteNode(loc: 2)
        
        tree_i.traverse()
        
        let tree_s = Tree1(7, root: Node<String>(data: "root"))
        tree_s.addNode(loc: 0, direction: .left, node: Node<String>(data: "one"))
        tree_s.addNode(loc: 1, direction: .right, node: Node<String>(data: "two"))
        
        tree_s.traverse()
    })
    
    scope(of: "link-tree", execute: true) {
        
        let tree_i = Tree2(root: Node<Int>(data: 0))
        tree_i.addNode(loc: 0, direction: .right, node: Node<Int>(index: 1, data: 4))
        tree_i.addNode(loc: 1, direction: .left, node: Node<Int>(index: 2, data: 5))
        tree_i.addNode(loc: 2, direction: .right, node: Node<Int>(index: 3, data: 6))
        
        tree_i.preorderTraversal()
        tree_i.inorderTraversal()
        tree_i.postorderTraversal()
        
        tree_i.searchNode(loc: 3)?.printNode()
        tree_i.deleteNode(loc: 1)
        
        tree_i.preorderTraversal()
        tree_i.inorderTraversal()
        tree_i.postorderTraversal()
        
        let tree_s = Tree2(root: Node<String>(data: "root"))
        tree_s.addNode(loc: 0, direction: .left, node: Node<String>(index: 1, data: "one"))
        tree_s.addNode(loc: 1, direction: .right, node: Node<String>(index: 2, data: "two"))
        tree_s.addNode(loc: 2, direction: .left, node: Node<String>(index: 3, data: "three"))
        tree_s.addNode(loc: 3, direction: .right, node: Node<String>(index: 4, data: "four"))
        tree_s.addNode(loc: 4, direction: .left, node: Node<String>(index: 5, data: "five"))
        tree_s.addNode(loc: 5, direction: .right, node: Node<String>(index: 6, data: "six"))
        tree_s.addNode(loc: 6, direction: .left, node: Node<String>(index: 7, data: "seven"))
        
        tree_s.preorderTraversal()
        tree_s.inorderTraversal()
        tree_s.postorderTraversal()
    }
}

scope(of: "map", execute: true) {
    
    let map_s = Map<String>(8)
    map_s.addNode(Node<String>(data: "A"))
    map_s.addNode(Node<String>(data: "B"))
    map_s.addNode(Node<String>(data: "C"))
    map_s.addNode(Node<String>(data: "D"))
    map_s.addNode(Node<String>(data: "E"))
    map_s.addNode(Node<String>(data: "F"))
    map_s.addNode(Node<String>(data: "G"))
    map_s.addNode(Node<String>(data: "H"))
    
    map_s.setValueToMatrixForUndirectedGraph(row: 0, col: 1)
    map_s.setValueToMatrixForUndirectedGraph(row: 0, col: 3)
    map_s.setValueToMatrixForUndirectedGraph(row: 1, col: 2)
    map_s.setValueToMatrixForUndirectedGraph(row: 1, col: 5)
    map_s.setValueToMatrixForUndirectedGraph(row: 3, col: 6)
    map_s.setValueToMatrixForUndirectedGraph(row: 3, col: 7)
    map_s.setValueToMatrixForUndirectedGraph(row: 6, col: 7)
    map_s.setValueToMatrixForUndirectedGraph(row: 2, col: 4)
    map_s.setValueToMatrixForUndirectedGraph(row: 4, col: 5)

    map_s.printMatrix()
    map_s.depthFirstTraverse(loc: 0)
    map_s.resetNode()
    map_s.breadthFirstTraverse(loc: 0)
    
    scope(of: "prim-tree / kruskal-tree", execute: true, action: {
        
        let map = Map<String>(6)
        map.addNode(Node<String>(data: "A"))
        map.addNode(Node<String>(data: "B"))
        map.addNode(Node<String>(data: "C"))
        map.addNode(Node<String>(data: "D"))
        map.addNode(Node<String>(data: "E"))
        map.addNode(Node<String>(data: "F"))
        
        map.setValueToMatrixForUndirectedGraph(row: 0, col: 1, val: 6)
        map.setValueToMatrixForUndirectedGraph(row: 0, col: 4, val: 5)
        map.setValueToMatrixForUndirectedGraph(row: 0, col: 5, val: 1)
        map.setValueToMatrixForUndirectedGraph(row: 1, col: 2, val: 3)
        map.setValueToMatrixForUndirectedGraph(row: 1, col: 5, val: 2)
        map.setValueToMatrixForUndirectedGraph(row: 2, col: 5, val: 8)
        map.setValueToMatrixForUndirectedGraph(row: 2, col: 3, val: 7)
        map.setValueToMatrixForUndirectedGraph(row: 3, col: 5, val: 4)
        map.setValueToMatrixForUndirectedGraph(row: 3, col: 4, val: 2)
        map.setValueToMatrixForUndirectedGraph(row: 4, col: 5, val: 9)
        
        map.printMatrix()
        map.primTree(loc: 0)
        map.kruskalTree()
    })
}

public func timing(_ action: () -> ()) {
    let time = NSDate().timeIntervalSince1970
    action()
    print("timing: \(NSDate().timeIntervalSince1970 - time)")
}

public func randomList(_ num: UInt32) -> [Int] {
    var list = [Int]()
    for _ in 0..<num {
        list.append(Int(arc4random() % num) + 1)
    }
    return list;
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}

scope(of: "Enumerate", execute: true) {
    money100chicken100()
    Enumerate.main()
}

scope(of: "coursera", execute: false) {
    
    scope(of: "maxPairwiseProduct", execute: false, action: {
        while (true) {
            let n = 1000/*4*/.arc4random + 2
            print(n)
            var a = [Int]()
            for _ in 0..<n {
                a.append(100000/*10*/.arc4random)
            }
            for i in 0..<n {
                print(a[i], terminator:" ")
            }
            print()
            let res1 = maxPairwiseProduct(numbers: a)
            let res2 = maxPairwiseProductFast(numbers: a)
            if res1 != res2 {
                print("Wrong answer: \(res1) \(res2)")
                break
            } else {
                print("OK")
            }
        }
    })
    
    scope(of: "fibonacci", execute: false, action: {
        while (true) {
            let n = 40.arc4random
            print(n)
            let res1 = fibRecurs(n: n)
            let res2 = fibList(n: n)
            if res1 != res2 {
                print("Wrong answer: \(res1) \(res2)")
                break
            } else {
                print("OK")
            }
        }
    })
    
    scope(of: "greatestCommonDivisor", execute: false, action: {
        while (true) {
            let a = 1000000.arc4random
            let b = 1000000.arc4random
            print("\(a) - \(b)")
            let res1 = naiveGCD(a: a, b: b)
            let res2 = euclidGCD(a: a, b: b)
            if res1 != res2 {
                print("Wrong answer: \(res1) \(res2)")
                break
            } else {
                print("OK")
            }
        }
    })
    
    scope(of: "largestNumber", execute: false, action: {
        
        while (true) {
            let n = randomList(100)
            let res1 = largestNumber(n)
            let res2 = n.sorted(by: >)
            if res1 != res2 {
                print("Wrong answer: \(res1) \(res2)")
                break
            } else {
                print("OK")
            }
        }
    })
    
    scope(of: "minRefills", execute: false, action: {
        let x = [200, 375, 550, 750, 950], n = x.count
        print(minRefills(x: x, n: n, L: 400) ?? "impossible")
    })
}

scope(of: "sort", execute: false) {
    
    scope(of: "systemsort", execute: true, action: {
        let list = randomList(10000)
        timing {_ = list.sorted()}
        //        print(list.sorted())
    })
    
    scope(of: "systemsort2", execute: true, action: {
        let list = randomList(10000)
        timing {_ = list.sorted {$0 < $1}}
        //        print(list.sorted {$0 < $1})
    })
    
    scope(of: "selectsort", execute: true, action: {
        var list = randomList(10000)
        timing {selectSort(list: &list)}
        //        print(list)
    })
    
    scope(of: "opt_selectsort", execute: true, action: {
        var list = randomList(10000)
        timing {optimizationSelectSort(list: &list)}
        //        print(list)
    })
    
    scope(of: "popsort", execute: true, action: {
        var list = randomList(10000)
        timing {popSort(list: &list)}
        //        print(list)
    })
    
    scope(of: "opt_popsort", execute: true, action: {
        var list = randomList(10000)
        timing {optimizationPopSort(list: &list)}
        //        print(list)
    })
    
    scope(of: "quicksort", execute: true, action: {
        var list = randomList(10000)
        timing {quickSort(list: &list)}
        //        print(list)
    })
}

scope(of: "search", execute: false) {
    
    scope(of: "binsearch", execute: true, action: {
        let list = randomList(10000)
        var index = 0
        timing {index = binSearch(list: list.sorted {$0 < $1}, find: 6)}
        print("index: \(index)")
    })
    
    scope(of: "rec_binsearch", execute: true, action: {
        let list = randomList(10000)
        var index = 0
        timing { index = recursiveBinSearch(list: list.sorted {$0 < $1}, find: 6)}
        print("index: \(index)")
    })
    
    scope(of: "findMedianSortedArrays", execute: true, action: {
        
        var array1 = randomList(1000001)
        var array2 = randomList(1000000)
        quickSort(list: &array1)
        quickSort(list: &array2)
        print(findMedianSortedArrays_1(array1, array2))
        print(findMedianSortedArrays_2(array1, array2))
        print(findMedianSortedArrays_3(array1, array2))
        print(findMedianSortedArrays_4(array1, array2))
        
        scope(of: "findMedianSortedArrays_1", execute: true, action: {
            var array1 = randomList(1000000)
            var array2 = randomList(1000000)
            quickSort(list: &array1)
            quickSort(list: &array2)
            timing { findMedianSortedArrays_1(array1, array2) }
        })
        
        scope(of: "findMedianSortedArrays_2", execute: true, action: {
            var array1 = randomList(1000000)
            var array2 = randomList(1000000)
            quickSort(list: &array1)
            quickSort(list: &array2)
            timing { findMedianSortedArrays_2(array1, array2) }
        })
        
        scope(of: "findMedianSortedArrays_3", execute: true, action: {
            var array1 = randomList(1000000)
            var array2 = randomList(1000000)
            quickSort(list: &array1)
            quickSort(list: &array2)
            timing { findMedianSortedArrays_3(array1, array2) }
        })
        scope(of: "findMedianSortedArrays_4", execute: true, action: {
            var array1 = randomList(1000000)
            var array2 = randomList(1000000)
            quickSort(list: &array1)
            quickSort(list: &array2)
            timing { findMedianSortedArrays_4(array1, array2) }
        })
        
    })
}

scope(of: "math", execute: false) {
    
    scope(of: "pow", execute: true, action: {
        print(_pow_1(3, 4))
        print(_pow_2(3, 4))
        print(_pow_3(3, 4))
    })
}

