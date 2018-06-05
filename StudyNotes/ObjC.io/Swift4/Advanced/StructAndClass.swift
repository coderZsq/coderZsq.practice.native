//
//  StructAndClass.swift
//  Advanced
//
//  Created by 朱双泉 on 2018/6/4.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

struct StructAndClass {
    
    static func run() {
        
        let mutableArray: NSMutableArray = [1, 2, 3]
        for _ in mutableArray {
            mutableArray.removeLastObject()
        }
        
        var mutableArray1 = [1, 2, 3]
        for _ in mutableArray1 {
            mutableArray1.removeLast()
        }
        
        let otherArray = mutableArray
        mutableArray.add(4)
        print(otherArray)
        
        func scanRemainingBytes(scanner: BinaryScanner) {
            while let byte = scanner.scanByte() {
                print(byte)
            }
        }
        
        let scanner = BinaryScanner(data: Data("hi".utf8))
        print(scanRemainingBytes(scanner: scanner))
        #if false
        for _ in 0..<Int.max {
            let newScanner = BinaryScanner(data: Data("hi".utf8))
            DispatchQueue.global().async {
                print(scanRemainingBytes(scanner: newScanner))
            }
            print(scanRemainingBytes(scanner: newScanner))
        }
        #endif
        
        var a = 42
        var b = a
        b += 1
        print(b)
        print(a)
        
        let origin = Point(x: 0, y: 0)
//        Cannot assign to property: 'origin' is a 'let' constant
//        origin.x = 10
        
        var otherPoint = Point(x: 0, y: 0)
        otherPoint.x += 10
        print(otherPoint)
        
        var thirdPoint = origin
        thirdPoint.x += 10
        print(thirdPoint)
        print(origin)
        
        let rect = Rectangle(origin: Point.zero, size: Size(width: 320, height: 480))
        
        var screen = Rectangle(width: 320, height: 480) {
            didSet {
                print("Screen changed: \(screen)")
            }
        }
        screen.origin.x = 10
        
        var screens: [Rectangle] = [] {
            didSet {
                print("Screebs array changed: \(screen)")
            }
        }
        screens.append(Rectangle(width: 320, height: 480))
        screens[0].origin.x += 100
        
        print(screen.origin + Point(x: 10, y: 10))
        
        screen.translate(by: Point(x: 10, y: 10))
        print(screen)
        
        let otherScreen = screen
//        Cannot use mutating member on immutable value: 'otherScreen' is a 'let' constant
//        otherScreen.translate(by: Point(x: 10, y: 10))
        
        let point = Point.zero
//        Cannot assign to property: 'point' is a 'let' constant
//        point.x = 10
        
        print(screen.translated(by: Point(x: 20, y: 20)))
        
        screen = translatedByTenTen(rectangle: screen)
        print(screen)
        
        translateByTwentyTwenty(rectangle: &screen)
        print(screen)
        
        let immutableScreen = screen
//        Cannot pass immutable value as inout argument: 'immutableScreen' is a 'let' constant
//        translateByTwentyTwenty(rectangle: &immutableScreen)
        
        var array = [Point(x: 0, y: 0), Point(x: 10, y: 10)]
        array[0] += Point(x: 100, y: 100)
        print(array)
        
        var myPoint = Point.zero
        myPoint += Point(x: 10, y: 10)
        print(myPoint)
        #if false
        for _ in 0..<Int.max {
            let newScanner = BinaryScanner(data: Data("hi".utf8))
            DispatchQueue.global().async {
                scanRemainingBytes(scanner: newScanner)
            }
            scanRemainingBytes(scanner: newScanner)
        }

        for _ in 0..<Int.max {
            let newScanner = BinaryScanner(data: Data("hi".utf8))
            DispatchQueue.global().async {
                while let byte = newScanner.scanByte() {
                    print(byte)
                }
            }
            while let byte = newScanner.scanByte() {
                print(byte)
            }
        }
        #endif
        
        var x = [1, 2, 3]
        var y = x
        
        x.append(5)
        y.removeLast()
        print(x)
        print(y)
        
        var input: [UInt8] = [0x0b, 0xab, 0xf0, 0x0d]
        var other: [UInt8] = [0x0d]
        var d = Data(bytes: input)
        var e = d
        d.append(contentsOf: other)
        print(d)
        print(e)
        
        var f = NSMutableData(bytes: &input, length: input.count)
        var g = f
        f.append(&other, length: other.count)
        print(f)
        print(g)
        print(f === g)
        #if false
        let theData = NSData(base64Encoded: "wAEP/w==")!
        var x1 = MyData(theData)
        let y1 = x1
        print(x1._data === y1._data)
        x1.append(0x55)
        print(y1)
        print(x1._data === y1._data)
        
        var buffer = MyData(NSData())
        for byte in 0..<5 as CountableRange<UInt8> {
            buffer.append(byte)
        }
        #endif
        var x2 = Box(NSMutableData())
        print(isKnownUniquelyReferenced(&x2))
        
        var y2 = x2
        print(isKnownUniquelyReferenced(&x2))
        
        var bytes = MyData()
        var copy = bytes
        for byte in 0..<5 as CountableRange<UInt8> {
            print("Append 0x\(String(byte, radix: 16))")
            bytes.append(byte)
        }
        print(bytes)
        print(copy)
        
        var s = COWStruct()
        print(s.change())
        
        var original = COWStruct()
        var copy1 = original
        print(original.change())
        
        var array1 = [COWStruct()]
        print(array1[0].change())
        
        var otherArray1 = [COWStruct()]
        var x3 = array1[0]
        print(x3.change())
        
        var dict = ["key" : COWStruct()]
        print(dict["key"]?.change())
        
        var d1 = ContainerStruct(storage: COWStruct())
        print(d1.storage.change())
        print(d1["test"].change())
        
        var i = 0
        func uniqueInteger() -> Int {
            i += 1
            return i
        }
        
        let otherFunction: () -> Int = uniqueInteger
        
        func uniqueIntegerProvider() -> () -> Int {
            var i = 0
            return {
                i += 1
                return i
            }
        }
        
        func uniqueIntegerProvider1() -> AnyIterator<Int> {
            var i = 0
            return AnyIterator {
                i += 1
                return i
            }
        }
        
        var john = Person(name: "John", parents: [])
        john.parents = [john]
        print(john)
        
        var myWindow: Window? = Window()
        myWindow = nil
        
        var window: Window? = Window()
        var view: View? = View(window: window!)
        window?.rootView = view
//        view = nil
//        window = nil
        
        let handle = FileHandle(forWritingAtPath: "out.html")
        let request = URLRequest(url: URL(string: "https://www.objc.io")!)
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            guard let theData = data else {return}
            handle?.write(theData)
        }.resume()
        
        window?.onRotate = {[weak view] in
            print("We not also need to update the view: \(String(describing: view))")
        }
        
        window?.onRotate = {[weak view, weak myWindow = window, x = 5 * 5] in
            print("We now also need to update the view: \(String(describing: view))")
            print("Because the window \(String(describing: myWindow)) changed")
        }
    }
}

class BinaryScanner {
    var position: Int
    let data: Data
    init(data: Data) {
        self.position = 0
        self.data = data
    }
}

extension BinaryScanner {
    func scanByte() -> UInt8? {
        guard position < data.endIndex else {
            return nil
        }
        position += 1
        return data[position - 1]
    }
}

struct Point {
    var x: Int
    var y: Int
}

struct Size {
    var width: Int
    var height: Int
}

struct Rectangle {
    var origin: Point
    var size: Size
}

extension Point {
    static let zero = Point(x: 0, y: 0)
}

extension Rectangle {
    init(x: Int = 0, y: Int = 0, width: Int, height: Int) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }
}

func +(lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

extension Rectangle {
    mutating func translate(by offset: Point) {
        origin = origin + offset
    }
}

extension Rectangle {
    func translated(by offset: Point) -> Rectangle {
        var copy = self
        copy.translate(by: offset)
        return copy
    }
}

func translatedByTenTen(rectangle: Rectangle) -> Rectangle {
    return rectangle.translated(by: Point(x: 10, y: 10))
}

func translateByTwentyTwenty(rectangle: inout Rectangle) {
    rectangle.translate(by: Point(x: 20, y: 20))
}

func +=(lhs: inout Point, rhs: Point) {
    lhs = lhs + rhs
}

struct MyData {
    #if false
    var _data: NSMutableData
    init(_ data: NSData) {
        _data = data.mutableCopy() as! NSMutableData
    }
    #endif
    #if false
    fileprivate var _data: NSMutableData
    fileprivate var _dataForWriting: NSMutableData {
        mutating get {
            _data = _data.mutableCopy() as! NSMutableData
            return _data
        }
    }
    init() {
        _data = NSMutableData()
    }
    init(_ data: NSData) {
        _data = data.mutableCopy() as! NSMutableData
    }
    #endif
    private var _data: Box<NSMutableData>
    var _dataForWriting: NSMutableData {
        mutating get {
            if !isKnownUniquelyReferenced(&_data) {
                _data = Box(_data.unbox.mutableCopy() as! NSMutableData)
                print("Making a copy")
            }
            return _data.unbox
        }
    }
    init() {
        _data = Box(NSMutableData())
    }
    init(_ data: NSData) {
        _data = Box(data.mutableCopy() as! NSMutableData)
    }
}

extension MyData {
    #if false
    func append(_ byte: UInt8) {
        var mutableByte = byte
        _data.append(&mutableByte, length: 1)
    }
    #endif
    mutating func append(_ byte: UInt8) {
        var mutableByte = byte
        _dataForWriting.append(&mutableByte, length: 1)
    }
}

final class Box<A> {
    var unbox: A
    init(_ value: A) {self.unbox = value}
}

final class Empty {}

struct COWStruct {
    var ref = Empty()
    
    mutating func change() -> String {
        if isKnownUniquelyReferenced(&ref) {
            return "No copy"
        } else {
            return "Copy"
        }
    }
}

struct ContainerStruct<A> {
    var storage: A
    subscript(s: String) -> A {
        get {return storage}
        set {storage = newValue}
    }
}

struct Person {
    let name: String
    var parents: [Person]
}

class View {
    #if false
    var window: Window
    init(window: Window) {
        self.window = window
    }
    #endif
    #if false
    var window: Window
    init(window: Window) {
        self.window = window
    }
    deinit {
        print("Deinit View")
    }
    #endif
    #if false
    unowned var window: Window
    init(window: Window) {
        self.window = window
    }
    deinit {
        print("Deinit View")
    }
    #endif
    var window: Window
    init(window: Window) {
        self.window = window
    }
    deinit {
        print("Deinit View")
    }
}

class Window {
    #if false
    var rootView: View?
    #endif
    #if false
    weak var rootView: View?
    deinit {
        print("Deinit Window")
    }
    #endif
    #if false
    var rootView: View?
    deinit {
        print("Deinit Window")
    }
    #endif
    weak var rootView: View?
    var onRotate: (() -> ())?
    deinit {
        print("Deinit Window")
    }
}
