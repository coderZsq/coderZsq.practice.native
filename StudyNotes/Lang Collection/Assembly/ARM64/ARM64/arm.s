;声明一个代码段
.text
.global _test, _add, _sub

;内部函数
mycode:
mov x0, #0x1
mov x1, #0x2
add x2, x0, x1
ret

;test函数的实现
_test:

;bl指令 = 8086 call, 使用bl ret才有效, 使用b ret没有效
bl mycode
mov x3, #0x2
mov x4, #0x1

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
