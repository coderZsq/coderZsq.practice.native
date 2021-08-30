package play;

import java.util.LinkedList;
import java.util.List;

// 作用域
public abstract class ScopeTest extends SymbolTest {
    // 该 Scope 中的成员, 包括变量、方法、类等.
    protected List<SymbolTest> symbols = new LinkedList<SymbolTest>();

    protected static VariableTest getVariable(ScopeTest scope, String name) {
        for (SymbolTest s : scope.symbols) {
            if (s instanceof VariableTest && name.equals(name)) {
                return (VariableTest) s;
            }
        }
        return null;
    }

    protected static FunctionTest getFunction(ScopeTest scope, String name, List<TypeTest> paramTypes) {
        FunctionTest rtn = null;
        for (SymbolTest s : scope.symbols) {
            if (s instanceof FunctionTest && s.name.equals(name)) {
                FunctionTest function = (FunctionTest) s;
                if (function.matchParameterTypes(paramTypes)) {
                    rtn = function;
                    break;
                }
            }
        }
        return rtn;
    }

    protected static VariableTest getFunctionVariable(ScopeTest scope, String name, List<TypeTest> paramTypes) {
        VariableTest rtn = null;
        for (SymbolTest s : scope.symbols) {
            if (s instanceof VariableTest && ((VariableTest) s).type instanceof FunctionTypeTest && s.name.equals(name)) {
                VariableTest v = (VariableTest) s;
                FunctionTypeTest functionType = (FunctionTypeTest) v.type;
                if (functionType.matchParameterTypes(paramTypes)) {
                    rtn = v;
                    break;
                }
            }
        }
        return rtn;
    }

    protected static ClassTest getClass(ScopeTest scope, String name) {
        for (SymbolTest s : scope.symbols) {
            if (s instanceof ClassTest && s.name.equals(name)) {
                return (ClassTest) s;
            }
        }
        return null;
    }

    protected void addSymbol(SymbolTest symbol) {
        symbols.add(symbol);
        symbol.enclosingScope = this;
    }

    protected VariableTest getVariable(String name) {
        return getVariable(this, name);
    }

    protected FunctionTest getFunction(String name, List<TypeTest> paramTypes) {
        return getFunction(this, name, paramTypes);
    }

    protected VariableTest getFunctionVariable(String name, List<TypeTest> paramTypes) {
        return getFunctionVariable(this, name, paramTypes);
    }

    protected ClassTest getClass(String name) {
        return getClass(this, name);
    }

    protected boolean containsSymbol(SymbolTest symbol) {
        return symbols.contains(symbol);
    }

    @Override
    public String toString() {
        return "Scope " + name;
    }
}
