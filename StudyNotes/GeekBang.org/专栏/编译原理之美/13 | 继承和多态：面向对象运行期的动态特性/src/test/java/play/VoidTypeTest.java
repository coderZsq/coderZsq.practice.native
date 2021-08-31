package play;

public class VoidTypeTest implements TypeTest {
    private static VoidTypeTest voidType = new VoidTypeTest();

    public VoidTypeTest() {
    }

    public static VoidTypeTest instance() {
        return voidType;
    }

    @Override
    public String getName() {
        return "void";
    }

    @Override
    public ScopeTest getEnclosingScope() {
        return null;
    }

    @Override
    public boolean isType(TypeTest type) {
        return this == type;
    }

    @Override
    public String toString() {
        return "void";
    }
}
