package play;

import org.antlr.v4.runtime.ParserRuleContext;

import java.util.LinkedList;
import java.util.List;
import java.util.Set;

// 函数作用域
public class FunctionTest extends ScopeTest implements FunctionTypeTest {

    // 参数
    protected List<VariableTest> parameters = new LinkedList<VariableTest>();
    // 返回值
    protected TypeTest returnType = null;
    protected Set<VariableTest> closureVariables;
    private List<TypeTest> paramTypes = null;

    protected FunctionTest(String name, ScopeTest enclosingScope, ParserRuleContext ctx) {
        this.name = name;
        this.enclosingScope = enclosingScope;
        this.ctx = ctx;
    }

    @Override
    public TypeTest getReturnType() {
        return returnType;
    }

    @Override
    public List<TypeTest> getParamTypes() {
        if (paramTypes == null) {
            paramTypes = new LinkedList<>();
        }
        for (VariableTest param : parameters) {
            paramTypes.add(param.type);
        }
        return paramTypes;
    }

    @Override
    public String toString() {
        return "Function " + name;
    }

    @Override
    public boolean isType(TypeTest type) {
        if (type instanceof FunctionType) {
            return DefaultFunctionTypeTest.isType(this, (FunctionTypeTest) type);
        }
        return false;
    }

    @Override
    public boolean matchParameterTypes(List<TypeTest> paramTypes) {
        if (parameters.size() != paramTypes.size()) {
            return false;
        }
        boolean match = true;
        for (int i = 0; i < paramTypes.size(); i++) {
            VariableTest var = parameters.get(i);
            TypeTest type = paramTypes.get(i);
            if (!var.type.isType(type)) {
                match = false;
                break;
            }
        }
        return match;
    }


    public boolean isMethod() {
        return enclosingScope instanceof ClassTest;
    }

    public boolean isConstructor() {
        if (enclosingScope instanceof ClassTest) {
            return enclosingScope.name.equals(name);
        }
        return false;
    }
}
