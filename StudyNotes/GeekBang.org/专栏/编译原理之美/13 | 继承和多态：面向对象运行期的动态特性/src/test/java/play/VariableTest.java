package play;

import org.antlr.v4.runtime.ParserRuleContext;

public class VariableTest extends SymbolTest {

    protected TypeTest type = null;
    protected Object defaultValue = null;
    protected Integer multiplicity = 1;

    protected VariableTest(String name, ScopeTest enclosingScopes, ParserRuleContext ctx) {
        this.name = name;
        this.enclosingScope = enclosingScopes;
        this.ctx = ctx;
    }

    public boolean isClassMember() {
        return enclosingScope instanceof ClassTest;
    }

    @Override
    public String toString() {
        return "Variable " + name + " -> " + type;
    }
}
