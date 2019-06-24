var age = 10

MemoryLayout<Int>.size
MemoryLayout<Int>.stride
MemoryLayout<Int>.alignment

MemoryLayout.size(ofValue: age)
MemoryLayout.stride(ofValue: age)
MemoryLayout.alignment(ofValue: age)

enum Password {
    case number(Int, Int, Int, Int)
    case other
}

var pwd = Password.number(5, 6, 4, 7)
pwd = .other

MemoryLayout<Password>.size
MemoryLayout<Password>.stride
MemoryLayout<Password>.alignment

enum Season : Int {
    case spring = 1, summer, autumn, winter
}

var s = Season.spring

MemoryLayout<Season>.size
MemoryLayout<Season>.stride
MemoryLayout<Season>.alignment

// 关联值, 原始值的区别
