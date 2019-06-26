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

enum TestEnum {
    case test1(Int, Int, Int)
    case test2(Int, Int)
    case test3(Int)
    case test4(Bool)
    case test5
}

MemoryLayout<TestEnum>.size
MemoryLayout<TestEnum>.stride
MemoryLayout<TestEnum>.alignment

// 1个字节存储成员值
// N个字节存储关联值 (N取占用内存最大的关联值), 任何一个case的关联值都共用这N个字节
// 共用体

// 01 00 00 00 00 00 00 00
// 02 00 00 00 00 00 00 00
// 03 00 00 00 00 00 00 00
// 00
// 00 00 00 00 00 00 00
var e = TestEnum.test1(1, 2, 3)

// 04 00 00 00 00 00 00 00
// 05 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00
// 01
// 00 00 00 00 00 00 00
e = .test2(4, 5)

// 06 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00
// 02
// 00 00 00 00 00 00 00
e = .test3(6)

// 01 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00
// 03
// 00 00 00 00 00 00 00
e = .test4(true)

// 00 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00
// 04
// 00 00 00 00 00 00 00
e = .test5

enum TestEnum2 {
    case test
}

var t = TestEnum2.test

MemoryLayout<TestEnum2>.size
MemoryLayout<TestEnum2>.stride
MemoryLayout<TestEnum2>.alignment

enum TestEnum3 {
    case test(Int)
}

var t2 = TestEnum3.test(10)

MemoryLayout<TestEnum3>.size
MemoryLayout<TestEnum3>.stride
MemoryLayout<TestEnum3>.alignment


e = TestEnum.test1(10, 20, 30)
/*  register read rip CPU要执行的下一条指令地址就存储在rip中
 ->  0x10000144f <+63>:   movq   $0xa, 0x1bee(%rip)        ; _dyld_private + 4
     0x10000145a <+74>:   leaq   0x1be7(%rip), %rax        ; TestEnum
     0x100001461 <+81>:   movq   $0x14, 0x1be4(%rip)       ; TestEnum + 4
     0x10000146c <+92>:   movq   $0x1e, 0x1be1(%rip)       ; TestEnum + 12
     0x100001477 <+103>:  movb   $0x0, 0x1be2(%rip)        ; TestEnum + 23 枚举的成员值
 */

switch e {
case let .test1(v1, v2, v3):
    print("test1", v1, v2, v3)
case let .test2(v1, v2):
    print("test3", v1, v2)
case let .test3(v1):
    print("test3", v1)
case let .test4(v1):
    print("test4", v1)
case .test5:
    print("test5")
}

