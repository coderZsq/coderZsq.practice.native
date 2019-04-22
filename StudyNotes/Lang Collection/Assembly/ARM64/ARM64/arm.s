;声明一个代码段
.text
.global _test, _add, _sub

;内部函数
mycode:
mov x0, #0x1
ret

;test函数的实现
_test:

bl mycode ;bl 将下一条指令的地址存储到 lr / x30 寄存器
mov x2, #0x2
ret ;ret 将 lr / x30 的值赋值给 pc 寄存器

;str指令 往内存中写入数据 stur stp 类似
;str w0, [x1]

;ldr指令 从内存中读取数据
;ldr x0, [x1]
;ldr w0, [x1]
;ldr w0, [x1, #0x1] ;读取正偏移地址的值 ldr
;ldr w0, [x1, #0x1]! ;读取正偏移地址的值 并将值赋值给 x1 寄存器
;ldur w0, [x1, #-0x1] ;读取负偏移地址的值 ldur

;ldp指令 从内存读取数据放到一对寄存器中
;ldp w0, w1, [x2, #0x10]

;bl指令 = 8086 call, 使用bl ret才有效, 使用b ret没有效
;bl mycode
;mov x3, #0x2
;mov x4, #0x1

;b指令带条件
;mov x0, #0x1
;mov x1, #0x3
;cmp x0, x1 ;x0 - x1 -> cspr
;beq mycode ;read cspr to jmp
;mov x0, #0x5
;ret

;mycode:
;mov x1, #0x6

;b指令 = 8086 jmp
;b mycode
;mov x0, #0x5
;mycode:
;mov x1, #0x6

;cmp指令
;mov x0, #0x1
;mov x1, #0x3
;cmp x0, x1 ;x0 - x1 -> cpsr

;mov指令
;mov x0, #0x8
;mov x1, x0

;add指令
;mov x0, #0x1
;mov x1, #0x2
;add x2, x0, x1 ;x2 = x0 + x1

;sub指令
;mov x0, #0x5
;mov x1, #0x2
;sub x2, x0, x1 ;x2 = x0 - x1

ret

;add函数的实现
;x0 - x7通常拿来存放函数的参数, 更多的参数使用堆栈来传递
;x0 通常用来存放函数的返回值
_add:
add x0, x0, x1
ret

;sub函数的实现
_sub:
sub x0, x0, x1
ret
