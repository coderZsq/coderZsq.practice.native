package play;

import org.antlr.v4.runtime.ParserRuleContext;

import java.util.List;

// 类作用域
public class ClassTest extends ScopeTest implements TypeTest {

    private static ClassTest rootClass = new ClassTest("Object", null);
    private ClassTest parentClass = null; //= rootClass;
    private ThisTest thisRef = null;
    private SuperTest superRef = null;
    private DefaultConstructorTest defaultConstructor = null;

    protected ClassTest(String name, ParserRuleContext ctx) {
        this.name = name;
        this.ctx = ctx;
        thisRef = new ThisTest(this, ctx);
        thisRef.type = this;
    }

    protected ClassTest getParentClass() {
        return parentClass;
    }

    protected void setParentClass(ClassTest theClass) {
        parentClass = theClass;

        superRef = new SuperTest(parentClass.parentClass, ctx);
        superRef.type = theClass;
    }

    public ThisTest getThis() {
        return thisRef;
    }

    public SuperTest getSuper() {
        return superRef;
    }

    @Override
    public String toString() {
        return "Class " + name;
    }

    @Override
    protected VariableTest getVariable(String name) {
        VariableTest rtn = super.getVariable(name);
        if (rtn == null && parentClass != null) {
            rtn = parentClass.getVariable(name);
        }
        return rtn;
    }

    @Override
    protected ClassTest getClass(String name) {
        ClassTest rtn = super.getClass(name);
        if (rtn == null && parentClass != null) {
            rtn = parentClass.getClass(name);
        }
        return rtn;
    }

    public FunctionTest findConstructor(List<TypeTest> paramTypes) {
        FunctionTest rtn = super.getFunction(name, paramTypes);
        return rtn;
    }

    protected FunctionTest getFunction(String name, List<TypeTest> paramTypes) {
        // 在本级中查找这个方法
        FunctionTest rtn = super.getFunction(name, paramTypes); // TODO 是否要检查 visibility

        // 如果在本级找不到, 那么递归的从父类中查找
        if (rtn == null && parentClass != null) {
            rtn = parentClass.getFunction(name, paramTypes);
        }

        return rtn;
    }

    @Override
    protected VariableTest getFunctionVariable(String name, List<TypeTest> paramTypes) {
        VariableTest rtn = super.getFunctionVariable(name, paramTypes);
        if (rtn == null && parentClass != null) {
            rtn = parentClass.getFunctionVariable(name, paramTypes);
        }
        return rtn;
    }

    @Override
    protected boolean containsSymbol(SymbolTest symbol) {
        if (symbol == thisRef || symbol == superRef) {
            return true;
        }
        boolean rtn = false;
        rtn = symbols.contains(symbol);
        if (!rtn && parentClass != null) {
            rtn = parentClass.containsSymbol(symbol);
        }
        return rtn;
    }

    @Override
    public boolean isType(TypeTest type) {
        if (this == type) return true;
        if (type instanceof ClassTest) {
            return ((ClassTest) type).isAncestor(this);
        }
        return false;
    }

    public boolean isAncestor(ClassTest theClass) {
        if (theClass.getParentClass() != null) {
            if (theClass.getParentClass() == this) {
                return true;
            } else {
                return isAncestor(theClass.getParentClass());
            }
        }
        return false;
    }

    protected DefaultConstructorTest defaultConstructor() {
        if (defaultConstructor == null) {
            defaultConstructor = new DefaultConstructorTest(this.name, this);
        }
        return defaultConstructor;
    }
}
