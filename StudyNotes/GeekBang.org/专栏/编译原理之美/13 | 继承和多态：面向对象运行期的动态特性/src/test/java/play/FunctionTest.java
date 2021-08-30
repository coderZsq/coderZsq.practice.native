package play;

import java.util.LinkedList;
import java.util.List;
import java.util.Set;

// 函数作用域
public class FunctionTest extends ScopeTest implements FunctionTypeTest {
    public Set<VariableTest> closureVariables;
    // 参数
    protected List<VariableTest> parameters = new LinkedList<VariableTest>();

    // 返回值
    protected Type returnType = null;

    public Object ctx;

    @Override
    public TypeTest getReturnType() {
        return null;
    }

    @Override
    public List<TypeTest> getParamTypes() {
        return null;
    }

    public boolean matchParameterTypes(List<TypeTest> paramTypes) {
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
