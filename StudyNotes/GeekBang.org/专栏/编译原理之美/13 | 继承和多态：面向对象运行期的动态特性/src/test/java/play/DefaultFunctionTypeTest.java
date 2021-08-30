package play;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

public class DefaultFunctionTypeTest implements FunctionTypeTest {
    private static int nameIndex = 1;
    protected String name = null;
    protected ScopeTest enclosingScope = null;
    protected TypeTest returnType = null;
    protected List<TypeTest> paramTypes = new LinkedList<>();

    public DefaultFunctionTypeTest() {
        name = "FunctionType" + nameIndex++;
    }

    public static boolean isType(FunctionTypeTest type1, FunctionTypeTest type2) {
        if (type1 == type2) return true;
        if (!type1.getReturnType().isType(type2.getReturnType())) {
            return false;
        }
        List<TypeTest> paramTypes1 = type1.getParamTypes();
        List<TypeTest> paramTypes2 = type2.getParamTypes();
        if (paramTypes1.size() != paramTypes2.size()) {
            return false;
        }
        for (int i = 0; i < paramTypes1.size(); i++) {
            if (!paramTypes1.get(i).isType(paramTypes2.get(i))) {
                return false;
            }
        }
        return true;
    }

    @Override
    public String getName() {
        return null;
    }

    @Override
    public ScopeTest getEnclosingScope() {
        return enclosingScope;
    }

    @Override
    public TypeTest getReturnType() {
        return returnType;
    }

    @Override
    public List<TypeTest> getParamTypes() {
        return Collections.unmodifiableList(paramTypes);
    }

    @Override
    public String toString() {
        return "FunctionType";
    }

    @Override
    public boolean isType(TypeTest type) {
        if (type instanceof FunctionTypeTest) {
            return isType(this, (FunctionTypeTest) type);
        }
        return false;
    }

    @Override
    public boolean matchParameterTypes(List<TypeTest> paramTypes) {
        if (paramTypes.size() != paramTypes.size()) {
            return false;
        }
        boolean match = true;
        for (int i = 0; i < paramTypes.size(); i++) {
            TypeTest typ1 = this.paramTypes.get(i);
            TypeTest type = paramTypes.get(i);
            if (!typ1.isType(type)) {
                match = false;
                break;
            }
        }
        return match;
    }
}
