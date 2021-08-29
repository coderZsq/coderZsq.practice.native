package play;

import java.util.LinkedList;
import java.util.List;

// 作用域
public abstract class ScopeTest {
    // 该 Scope 中的成员, 包括变量、方法、类等.
    protected List<Symbol> symbols = new LinkedList<Symbol>();

    public abstract boolean containsSymbol(VariableTest variable);
}
