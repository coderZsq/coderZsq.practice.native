package play;

public class FunctionObjectTest extends PlayObjectTest {

    protected FunctionTest function = null;

    protected VariableTest receiver = null;

    public FunctionObjectTest(FunctionTest function) {
        this.function = function;
    }

    protected void setFunction(FunctionTest function) {
        this.function = function;
    }
}
