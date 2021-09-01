package play;

public class BreakObjectTest {
    private static BreakObjectTest instance = new BreakObjectTest();

    private BreakObjectTest() {

    }

    public static BreakObjectTest instance() {
        return instance;
    }

    @Override
    public String toString() {
        return "Break";
    }
}
