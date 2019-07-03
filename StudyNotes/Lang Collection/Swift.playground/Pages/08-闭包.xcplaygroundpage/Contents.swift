
typealias Fn = (Int) -> Int
func getFn() -> Fn {
    var num = 0;
    func plus(_ i: Int) -> Int {
        num += i;
        return num
    }
    return plus
}

/*
 SwiftDemo`getFn():
 0x100001cf0 <+0>:  pushq  %rbp
 0x100001cf1 <+1>:  movq   %rsp, %rbp
 0x100001cf4 <+4>:  subq   $0x20, %rsp
 0x100001cf8 <+8>:  leaq   0x321(%rip), %rdi
 0x100001cff <+15>: movl   $0x18, %esi
 0x100001d04 <+20>: movl   $0x7, %edx
 0x100001d09 <+25>: callq  0x100001ee6               ; symbol stub for: swift_allocObject
 0x100001d0e <+30>: movq   %rax, %rdx
 0x100001d11 <+33>: addq   $0x10, %rdx
 0x100001d15 <+37>: movq   %rdx, %rsi
 0x100001d18 <+40>: movq   $0x0, 0x10(%rax)
 0x100001d20 <+48>: movq   %rax, %rdi
 0x100001d23 <+51>: movq   %rax, -0x8(%rbp)
 0x100001d27 <+55>: movq   %rdx, -0x10(%rbp)
 0x100001d2b <+59>: callq  0x100001f0a               ; symbol stub for: swift_retain
 0x100001d30 <+64>: movq   -0x8(%rbp), %rdi
 0x100001d34 <+68>: movq   %rax, -0x18(%rbp)
 0x100001d38 <+72>: callq  0x100001f04               ; symbol stub for: swift_release
 0x100001d3d <+77>: movq   -0x10(%rbp), %rax
 0x100001d41 <+81>: leaq   0x178(%rip), %rax         ; partial apply forwarder for plus #1 (Swift.Int) -> Swift.Int in SwiftDemo.getFn() -> (Swift.Int) -> Swift.Int at <compiler-generated>
 0x100001d48 <+88>: movq   -0x8(%rbp), %rdx
 0x100001d4c <+92>: addq   $0x20, %rsp
 0x100001d50 <+96>: popq   %rbp
 0x100001d51 <+97>: retq
 */

var fn = getFn()
fn(1)
fn(2)
fn(3)
fn(4)

/*
 (lldb) register read rax
 rax = 0x000000010079a100
 (lldb) x/5xg 0x000000010079a100
 0x10079a100: 0x0000000100002020 0x0000000200000002
 0x10079a110: 0x0000000000000000 0x0002000000000000
 0x10079a120: 0x0000000000000000
 1
 (lldb) x/5xg 0x000000010079a100
 0x10079a100: 0x0000000100002020 0x0000000200000002
 0x10079a110: 0x0000000000000001 0x0002000000000000
 0x10079a120: 0x0000000000000000
 3
 (lldb) x/5xg 0x000000010079a100
 0x10079a100: 0x0000000100002020 0x0000000200000002
 0x10079a110: 0x0000000000000003 0x0002000000000000
 0x10079a120: 0x0000000000000000
 6
 (lldb) x/5xg 0x000000010079a100
 0x10079a100: 0x0000000100002020 0x0000000200000002
 0x10079a110: 0x0000000000000006 0x0002000000000000
 0x10079a120: 0x0000000000000000
 10
 */

var fn1 = getFn()
MemoryLayout.stride(ofValue: fn1)
fn1(1)
fn1(3)
/*
 0x100000a2b <+235>: movq   0x686(%rip), %rax         ; SwiftDemo.fn1 : (Swift.Int) -> Swift.Int
 0x100000a32 <+242>: movq   0x687(%rip), %rcx         ; SwiftDemo.fn1 : (Swift.Int) -> Swift.Int + 8
 0x100000a39 <+249>: movq   %rcx, %rdi
 0x100000a3c <+252>: movq   %rax, -0xb0(%rbp)
 0x100000a43 <+259>: movq   %rcx, -0xb8(%rbp)
 0x100000a4a <+266>: callq  0x100000f08               ; symbol stub for: swift_retain
 0x100000a4f <+271>: leaq   -0x38(%rbp), %rdi
 0x100000a53 <+275>: movq   %rax, -0xc0(%rbp)
 0x100000a5a <+282>: callq  0x100000ef6               ; symbol stub for: swift_endAccess
 0x100000a5f <+287>: movl   $0x1, %r9d
 0x100000a65 <+293>: movl   %r9d, %edi
 0x100000a68 <+296>: movq   -0xb8(%rbp), %r13
 0x100000a6f <+303>: movq   -0xb0(%rbp), %rax
 0x100000a76 <+310>: callq  *%rax
 */
/*
 SwiftDemo`partial apply for plus #1 (_:) in getFn():
 ->  0x100000ed0 <+0>:  pushq  %rbp
 0x100000ed1 <+1>:  movq   %rsp, %rbp
 0x100000ed4 <+4>:  movq   %r13, %rsi
 0x100000ed7 <+7>:  callq  0x100000cc0               ; plus #1 (Swift.Int) -> Swift.Int in SwiftDemo.getFn() -> (Swift.Int) -> Swift.Int at main.swift:12
 0x100000edc <+12>: popq   %rbp
 0x100000edd <+13>: retq
 */
/*
 (lldb) register read rdi
 rdi = 0x0000000000000001
 (lldb) register read r13
 r13 = 0x00000001030040f0
 (lldb) register read rsi
 rsi = 0x00000001030040f0
 */
/*
 0x100000ce5 <+37>:  movq   %rdi, -0x48(%rbp)
 0x100000ce9 <+41>:  movq   %r10, %rdi
 0x100000cec <+44>:  movq   %rsi, -0x50(%rbp)
 ...
 0x100000d4b <+139>: movq   -0x48(%rbp), %rcx
 0x100000d4f <+143>: movq   -0x50(%rbp), %rdx
 0x100000d53 <+147>: addq   0x10(%rdx), %rcx
 */
var fn2 = getFn()
fn2(2)
fn2(4)
/*
 0x100000be3 <+675>: movq   0x4de(%rip), %rax         ; SwiftDemo.fn2 : (Swift.Int) -> Swift.Int
 0x100000bea <+682>: movq   0x4df(%rip), %rcx         ; SwiftDemo.fn2 : (Swift.Int) -> Swift.Int + 8
 0x100000bf1 <+689>: movq   %rcx, %rdi
 0x100000bf4 <+692>: movq   %rax, -0x120(%rbp)
 0x100000bfb <+699>: movq   %rcx, -0x128(%rbp)
 0x100000c02 <+706>: callq  0x100000f08               ; symbol stub for: swift_retain
 0x100000c07 <+711>: leaq   -0x80(%rbp), %rdi
 0x100000c0b <+715>: movq   %rax, -0x130(%rbp)
 0x100000c12 <+722>: callq  0x100000ef6               ; symbol stub for: swift_endAccess
 0x100000c17 <+727>: movl   $0x4, %r9d
 0x100000c1d <+733>: movl   %r9d, %edi
 0x100000c20 <+736>: movq   -0x128(%rbp), %r13
 0x100000c27 <+743>: movq   -0x120(%rbp), %rax
 0x100000c2e <+750>: callq  *%rax
 */

typealias Func = (Int) -> (Int, Int)

func getFuncs() -> (Func, Func) {
    var num1 = 0
    /*
     0x100001416 <+54>:  callq  0x100001e7a               ; symbol stub for: swift_allocObject
     0x10000141b <+59>:  movq   %rax, %rdx
     */
    var num2 = 0
    /*
     0x100001444 <+100>: callq  0x100001e7a               ; symbol stub for: swift_allocObject
     0x100001449 <+105>: movq   %rax, %rdx
     */
    func plus(_ i: Int) -> (Int, Int) {
        num1 += i
        num2 += i << 1
        return (num1, num2)
    }
    func minus(_ i: Int) -> (Int, Int) {
        num1 -= i
        num2 -= i << 1
        return (num1, num2)
    }
    return (plus, minus)
}

let (p, m) = getFuncs()
p(6)
m(5)
p(4)
/*
 (lldb) register read rax
 rax = 0x0000000100701c30
 (lldb) register read rax
 rax = 0x0000000103200180
 (lldb) x/5xg 0x0000000100701c30
 0x100701c30: 0x0000000100002058 0x0000000200000002
 0x100701c40: 0x0000000000000005 0x00027fff70991128
 0x100701c50: 0x00007fff8b995b38
 (lldb) x/5xg 0x0000000103200180
 0x103200180: 0x0000000100002058 0x0000000200000002
 0x103200190: 0x000000000000000a 0x0000000000000000
 0x1032001a0: 0x0000000000000000
 */
m(3)

var functions: [() -> Int] = []
for i in 1...3 {
    functions.append {i}
}
for f in functions {
    print("\(f())")
}

func getNumber() -> Int {
    let a = 10
    let b = 11
    print("----")
    return a + b
}

func getFirstPositive(_ v1: Int, _ v2: () -> Int) -> Int {
    return v1 > 0 ? v1 : v2()
}

func getFirstPositive(_ v1: Int, _ v2: @autoclosure () -> Int) -> Int {
    return v1 > 0 ? v1 : v2()
}
getFirstPositive(10, 20)
getFirstPositive(-2, 20)
getFirstPositive(0, -4)

getFirstPositive(10, getNumber())
getFirstPositive(10) {getNumber()}
