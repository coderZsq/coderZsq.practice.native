
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
print(fn(1))
print(fn(2))
print(fn(3))
print(fn(4))

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

