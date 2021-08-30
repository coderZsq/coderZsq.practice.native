package play;

import org.antlr.v4.runtime.ParserRuleContext;

// 编译过程中产生的变量、函数、类、块, 都被称为符号
public abstract class SymbolTest {
    // 符号的名称
    protected String name = null;

    // 所属作用域
    protected ScopeTest enclosingScope = null;

    // 可见性, 比如 public 还是 private
    protected int visibility = 0;

    // Symbol 关联的AST节点
    protected ParserRuleContext ctx = null;
}
