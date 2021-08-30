package play;

public class DefaultConstructorTest extends FunctionTest {

    protected DefaultConstructorTest(String name, ClassTest theClass) {
        super(name, theClass, null);
    }

    public ClassTest Class() {
        return (ClassTest) enclosingScope;
    }

}
