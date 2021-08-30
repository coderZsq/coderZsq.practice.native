package play;

import org.antlr.v4.runtime.ParserRuleContext;

import java.util.List;

// 类作用域
public class ClassTest extends ScopeTest implements TypeTest {

    private ClassTest parentClass = null; //= rootClass;
    private ThisTest thisRef = null;
    private SuperTest superRef = null;
    private DefaultConstructorTest defaultConstructor = null;


    public ClassTest(String name, ParserRuleContext ctx) {
        this.name = name;
        this.ctx = ctx;
        thisRef = new ThisTest(this, ctx);
        thisRef.type = this;
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

    protected FunctionTest getFunction(String name, List<TypeTest> paramTypes) {
        // 在本级中查找这个方法
        FunctionTest rtn = super.getFunction(name, paramTypes); // TODO 是否要检查 visibility

        // 如果在本级找不到, 那么递归的从父类中查找
        if (rtn == null && parentClass != null) {
            rtn = parentClass.getFunction(name, paramTypes);
        }

        return rtn;
    }

    public ClassTest getParentClass() {
        return null;
    }
}
