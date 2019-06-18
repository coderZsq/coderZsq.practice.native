//
//  main.m
//  LLVM
//
//  Created by 朱双泉 on 2019/6/18.
//  Copyright © 2019 Castie!. All rights reserved.
//

#include <stdio.h>

#define AGE 40

int main(int argc, const char * argv[]) {
    
    int a = 10;
    int b = 20;
    int c = a + b + AGE;
    
    return 0;
}

void test(int a, int b) {
    int c = a + b - 4;
}

/*
 |-FunctionDecl 0x7fc5b80774d0 <line:22:1, line:24:1> line:22:6 test 'void (int, int)'
 | |-ParmVarDecl 0x7fc5b8077358 <col:11, col:15> col:15 used a 'int'
 | |-ParmVarDecl 0x7fc5b80773d0 <col:18, col:22> col:22 used b 'int'
 | `-CompoundStmt 0x7fc5b8077718 <col:25, line:24:1>
 |   `-DeclStmt 0x7fc5b8077700 <line:23:5, col:22>
 |     `-VarDecl 0x7fc5b80775b0 <col:5, col:21> col:9 c 'int' cinit
 |       `-BinaryOperator 0x7fc5b80776d8 <col:13, col:21> 'int' '-'
 |         |-BinaryOperator 0x7fc5b8077690 <col:13, col:17> 'int' '+'
 |         | |-ImplicitCastExpr 0x7fc5b8077660 <col:13> 'int' <LValueToRValue>
 |         | | `-DeclRefExpr 0x7fc5b8077610 <col:13> 'int' lvalue ParmVar 0x7fc5b8077358 'a' 'int'
 |         | `-ImplicitCastExpr 0x7fc5b8077678 <col:17> 'int' <LValueToRValue>
 |         |   `-DeclRefExpr 0x7fc5b8077638 <col:17> 'int' lvalue ParmVar 0x7fc5b80773d0 'b' 'int'
 |         `-IntegerLiteral 0x7fc5b80776b8 <col:21> 'int' 4
 */
