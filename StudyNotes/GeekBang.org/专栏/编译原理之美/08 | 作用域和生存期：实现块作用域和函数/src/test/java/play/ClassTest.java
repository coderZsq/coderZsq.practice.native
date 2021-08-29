package play;

// 类作用域
public class ClassTest extends ScopeTest implements Type {
    @Override
    public String getName() {
        return null;
    }

    @Override
    public Scope getEnclosingScope() {
        return null;
    }

    @Override
    public boolean isType(Type type) {
        return false;
    }

    @Override
    public boolean containsSymbol(VariableTest variable) {
        return false;
    }
}
