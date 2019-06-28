struct Point {
//    var x: Int
//    var y: Int
//    init() {
//        x = 0
//        y = 0
//    }
//    var x = 10
//    var y = 20
//    var b = true
    var x = 3
    var y = 4
}

var point = Point()
/*
 ->  0x100000b5f <+15>: callq  0x100000c10               ; SwiftDemo.Point.init() -> SwiftDemo.Point at main.swift:13
 
 SwiftDemo`Point.init():
 ->  0x100000c10 <+0>:  pushq  %rbp
     0x100000c11 <+1>:  movq   %rsp, %rbp
     0x100000c14 <+4>:  xorps  %xmm0, %xmm0
     0x100000c17 <+7>:  movaps %xmm0, -0x10(%rbp)
     0x100000c1b <+11>: movq   $0x0, -0x10(%rbp)
     0x100000c23 <+19>: movq   $0x0, -0x8(%rbp)
     0x100000c2b <+27>: xorl   %eax, %eax
     0x100000c2d <+29>: movl   %eax, %ecx
     0x100000c2f <+31>: movq   %rcx, %rax
     0x100000c32 <+34>: movq   %rcx, %rdx
     0x100000c35 <+37>: popq   %rbp
     0x100000c36 <+38>: retq
 */

MemoryLayout<Point>.size
MemoryLayout<Point>.stride
MemoryLayout<Point>.alignment

print("point变量的地址", Mems.ptr(ofVal: &point))
print("point变量的内存", Mems.memStr(ofVal: &point))

class Size {
    var width = 1
    var height = 2
}

var size = Size()

/*
     SwiftDemo`Size.__allocating_init():
 ->  0x100001414 <+36>: callq  0x100001960               ; SwiftDemo.Size.__allocating_init() -> SwiftDemo.Size at main.swift:15
 
     libswiftCore.dylib`swift_allocObject:
     0x10000198f <+47>: callq  0x100001cfc               ; symbol stub for: swift_allocObject
 
     libswiftCore.dylib`swift_slowAlloc:
     0x7fff65a6441f <+15>: callq  0x7fff65a64390            ; swift_slowAlloc
 
     libsystem_malloc.dylib`malloc:
     0x7fff65a643a4 <+20>: callq  0x7fff65adbe88            ; symbol stub for: malloc
 
     libsystem_malloc.dylib`malloc_zone_malloc:
     0x7fff66511776 <+16>: callq  0x7fff66511798            ; malloc_zone_malloc
 */

MemoryLayout<Size>.size
MemoryLayout<Size>.stride
MemoryLayout<Size>.alignment

print("size变量的地址", Mems.ptr(ofVal: &size))
print("size变量的内存", Mems.memStr(ofVal: &size))
print("size所指向内存的地址", Mems.ptr(ofRef: size))
print("size所指向内存的内容", Mems.memStr(ofRef: size))

Mems.size(ofRef: size)

import Foundation

var ptr = malloc(17) // malloc函数分配的内存大小总是16的倍数
malloc_size(ptr)

malloc_size(Mems.ptr(ofRef: size))
