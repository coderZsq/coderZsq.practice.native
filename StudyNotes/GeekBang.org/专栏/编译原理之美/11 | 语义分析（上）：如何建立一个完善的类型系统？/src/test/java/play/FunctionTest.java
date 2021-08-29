package play;

import java.util.LinkedList;
import java.util.List;
import java.util.Set;

// 函数作用域
public class FunctionTest extends ScopeTest implements FunctionType {
    public Set<VariableTest> closureVariables;
    // 参数
    protected List<VariableTest> parameters = new LinkedList<VariableTest>();

    // 返回值
    protected Type returnType = null;

    public Object ctx;

    @Override
    public Type getReturnType() {
        return null;
    }

    @Override
    public List<Type> getParamTypes() {
        return null;
    }

    @Override
    public boolean matchParameterTypes(List<Type> paramTypes) {
        return false;
    }

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

    public boolean isMethod() {
        return false;
    }
}
