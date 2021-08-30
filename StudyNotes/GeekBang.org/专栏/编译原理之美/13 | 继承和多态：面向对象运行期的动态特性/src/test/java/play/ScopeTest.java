package play;

import java.util.LinkedList;
import java.util.List;

// 作用域
public abstract class ScopeTest extends SymbolTest {
    // 该 Scope 中的成员, 包括变量、方法、类等.
    protected List<SymbolTest> symbols = new LinkedList<SymbolTest>();

    public abstract boolean containsSymbol(VariableTest variable);

    protected static FunctionTest getFunction(ScopeTest scope, String name, List<TypeTest> paramTypes){
        FunctionTest rtn = null;
        for (SymbolTest s : scope.symbols) {
            if (s instanceof FunctionTest && s.name.equals(name)) {
                FunctionTest function = (FunctionTest) s;
                if (function.matchParameterTypes(paramTypes)){
                    rtn = function;
                    break;
                }
            }
        }


        return rtn;
    }

    protected FunctionTest getFunction(String name, List<TypeTest> paramTypes){
        return getFunction(this,name,paramTypes);
    }
}
