package play;

import java.util.List;

// 类作用域
public class ClassTest extends ScopeTest implements TypeTest {
    @Override
    public boolean containsSymbol(VariableTest variable) {
        return false;
    }

    @Override
    public String getName() {
        return null;
    }

    @Override
    public ScopeTest getEnclosingScope() {
        return null;
    }

    public FunctionTest findConstructor(List<TypeTest> paramTypes) {
        return null;
    }
}
