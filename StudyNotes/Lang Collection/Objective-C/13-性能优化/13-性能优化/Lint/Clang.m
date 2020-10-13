//
//  Clang.m
//  13-性能优化
//
//  Created by 朱双泉 on 2020/10/13.
//

clang -cc1 -analyze -analyzer-checker=debug.DumpCFG Clang.m // 显示控制流程图

int main()
 [B2 (ENTRY)]
   Succs (1): B1

 [B1]
   1: int a;
   2: 10
   3: int b = 10;
   4: b
   5: [B1.4] (ImplicitCastExpr, LValueToRValue, int)
   6: a
   7: [B1.6] = [B1.5]
   8: a
   9: [B1.8] (ImplicitCastExpr, LValueToRValue, int)
  10: return [B1.9];
   Preds (1): B2
   Succs (1): B0

 [B0 (EXIT)]
   Preds (1): B1

clang -fmodules -E -Xclang -dump-tokens Clang.m // 词法分析

int 'int'     [StartOfLine]    Loc=<Clang.m:31:1>
identifier 'main'     [LeadingSpace]    Loc=<Clang.m:31:5>
l_paren '('        Loc=<Clang.m:31:9>
r_paren ')'        Loc=<Clang.m:31:10>
l_brace '{'     [StartOfLine]    Loc=<Clang.m:32:1>
int 'int'     [StartOfLine] [LeadingSpace]    Loc=<Clang.m:33:5>
identifier 'a'     [LeadingSpace]    Loc=<Clang.m:33:9>
semi ';'        Loc=<Clang.m:33:10>
int 'int'     [StartOfLine] [LeadingSpace]    Loc=<Clang.m:34:5>
identifier 'b'     [LeadingSpace]    Loc=<Clang.m:34:9>
equal '='     [LeadingSpace]    Loc=<Clang.m:34:11>
numeric_constant '10'     [LeadingSpace]    Loc=<Clang.m:34:13>
semi ';'        Loc=<Clang.m:34:15>
identifier 'a'     [StartOfLine] [LeadingSpace]    Loc=<Clang.m:35:5>
equal '='     [LeadingSpace]    Loc=<Clang.m:35:7>
identifier 'b'     [LeadingSpace]    Loc=<Clang.m:35:9>
semi ';'        Loc=<Clang.m:35:10>
return 'return'     [StartOfLine] [LeadingSpace]    Loc=<Clang.m:36:5>
identifier 'a'     [LeadingSpace]    Loc=<Clang.m:36:12>
semi ';'        Loc=<Clang.m:36:13>
r_brace '}'     [StartOfLine]    Loc=<Clang.m:37:1>
eof ''        Loc=<Clang.m:37:2>

clang -fmodules -fsyntax-only -Xclang -ast-dump Clang.m // 语法分析

TranslationUnitDecl 0x7fae48822c08 <<invalid sloc>> <invalid sloc>
|-TypedefDecl 0x7fae488234a0 <<invalid sloc>> <invalid sloc> implicit __int128_t '__int128'
| `-BuiltinType 0x7fae488231a0 '__int128'
|-TypedefDecl 0x7fae48823510 <<invalid sloc>> <invalid sloc> implicit __uint128_t 'unsigned __int128'
| `-BuiltinType 0x7fae488231c0 'unsigned __int128'
|-TypedefDecl 0x7fae488235b0 <<invalid sloc>> <invalid sloc> implicit SEL 'SEL *'
| `-PointerType 0x7fae48823570 'SEL *'
|   `-BuiltinType 0x7fae48823400 'SEL'
|-TypedefDecl 0x7fae48823698 <<invalid sloc>> <invalid sloc> implicit id 'id'
| `-ObjCObjectPointerType 0x7fae48823640 'id'
|   `-ObjCObjectType 0x7fae48823610 'id'
|-TypedefDecl 0x7fae48823778 <<invalid sloc>> <invalid sloc> implicit Class 'Class'
| `-ObjCObjectPointerType 0x7fae48823720 'Class'
|   `-ObjCObjectType 0x7fae488236f0 'Class'
|-ObjCInterfaceDecl 0x7fae488237d0 <<invalid sloc>> <invalid sloc> implicit Protocol
|-TypedefDecl 0x7fae48823b68 <<invalid sloc>> <invalid sloc> implicit __NSConstantString 'struct __NSConstantString_tag'
| `-RecordType 0x7fae48823940 'struct __NSConstantString_tag'
|   `-Record 0x7fae488238a0 '__NSConstantString_tag'
|-TypedefDecl 0x7fae4900aa00 <<invalid sloc>> <invalid sloc> implicit __builtin_ms_va_list 'char *'
| `-PointerType 0x7fae48823bc0 'char *'
|   `-BuiltinType 0x7fae48822ca0 'char'
|-TypedefDecl 0x7fae4900ad08 <<invalid sloc>> <invalid sloc> implicit __builtin_va_list 'struct __va_list_tag [1]'
| `-ConstantArrayType 0x7fae4900acb0 'struct __va_list_tag [1]' 1
|   `-RecordType 0x7fae4900aaf0 'struct __va_list_tag'
|     `-Record 0x7fae4900aa58 '__va_list_tag'
`-FunctionDecl 0x7fae4900adb0 <Clang.m:56:1, line:62:1> line:56:5 main 'int ()'
  `-CompoundStmt 0x7fae4900b0f0 <line:57:1, line:62:1>
    |-DeclStmt 0x7fae4900af30 <line:58:5, col:10>
    | `-VarDecl 0x7fae4900aec8 <col:5, col:9> col:9 used a 'int'
    |-DeclStmt 0x7fae4900afe8 <line:59:5, col:15>
    | `-VarDecl 0x7fae4900af60 <col:5, col:13> col:9 used b 'int' cinit
    |   `-IntegerLiteral 0x7fae4900afc8 <col:13> 'int' 10
    |-BinaryOperator 0x7fae4900b088 <line:60:5, col:9> 'int' '='
    | |-DeclRefExpr 0x7fae4900b000 <col:5> 'int' lvalue Var 0x7fae4900aec8 'a' 'int'
    | `-ImplicitCastExpr 0x7fae4900b070 <col:9> 'int' <LValueToRValue>
    |   `-DeclRefExpr 0x7fae4900b038 <col:9> 'int' lvalue Var 0x7fae4900af60 'b' 'int'
    `-ReturnStmt 0x7fae4900b0e0 <line:61:5, col:12>
      `-ImplicitCastExpr 0x7fae4900b0c8 <col:12> 'int' <LValueToRValue>
        `-DeclRefExpr 0x7fae4900b0a8 <col:12> 'int' lvalue Var 0x7fae4900aec8 'a' 'int'

int main()
{
    int a;
    int b = 10;
    a = b;
    return a;
}
