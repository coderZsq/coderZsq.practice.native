package play;

public class ReturnObjectTest {
    Object returnValue = null;

    public ReturnObjectTest(Object returnValue) {
        this.returnValue = returnValue;
    }

    @Override
    public String toString() {
        return "ReturnObject";
    }
}
