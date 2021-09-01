package play;

public final class NullObjectTest extends ClassObjectTest {
    private static NullObjectTest instance = new NullObjectTest();

    private NullObjectTest() {

    }

    public static NullObjectTest instance() {
        return instance;
    }

    @Override
    public String toString() {
        return "Null";
    }
}
