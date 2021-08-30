package play;

public class PrimitiveTypeTest implements TypeTest {
    private String name = null;

    @Override
    public String getName() {
        return name;
    }

    @Override
    public ScopeTest getEnclosingScope() {
        return null;
    }

    @Override
    public String toString() {
        return name;
    }

    public PrimitiveTypeTest(String name) {
        this.name = name;
    }

    public static PrimitiveTypeTest Integer = new PrimitiveTypeTest("Integer");
    public static PrimitiveTypeTest Long = new PrimitiveTypeTest("Long");
    public static PrimitiveTypeTest Float = new PrimitiveTypeTest("Float");
    public static PrimitiveTypeTest Double = new PrimitiveTypeTest("Double");
    public static PrimitiveTypeTest Boolean = new PrimitiveTypeTest("Boolean");
    public static PrimitiveTypeTest Byte = new PrimitiveTypeTest("Byte");
    public static PrimitiveTypeTest Char = new PrimitiveTypeTest("Char");
    public static PrimitiveTypeTest Short = new PrimitiveTypeTest("Short");
    public static PrimitiveTypeTest String = new PrimitiveTypeTest("String");
    public static PrimitiveTypeTest Null = new PrimitiveTypeTest("Null");

    public static PrimitiveTypeTest getUpperType(TypeTest type1, TypeTest type2) {
        PrimitiveTypeTest type = null;

        if (type1 == PrimitiveTypeTest.String || type2 == PrimitiveTypeTest.String) {
            type = PrimitiveTypeTest.String;
        } else if (type1 == PrimitiveTypeTest.Double || type2 == PrimitiveTypeTest.Double) {
            type = PrimitiveTypeTest.Double;
        } else if (type1 == PrimitiveTypeTest.Float || type2 == PrimitiveTypeTest.Float) {
            type = PrimitiveTypeTest.Float;
        } else if (type1 == PrimitiveTypeTest.Long || type2 == PrimitiveTypeTest.Long) {
            type = PrimitiveTypeTest.Long;
        } else if (type1 == PrimitiveTypeTest.Integer || type2 == PrimitiveTypeTest.Integer) {
            type = PrimitiveTypeTest.Integer;
        } else if (type1 == PrimitiveTypeTest.Short || type2 == PrimitiveTypeTest.Short) {
            type = PrimitiveTypeTest.Short;
        } else {
            type = PrimitiveTypeTest.Byte; // TODO 以上这些规则有没有漏洞？
        }
        return type;
    }

    public static boolean isNumeric(TypeTest type) {
        if (type == PrimitiveTypeTest.Byte ||
                type == PrimitiveTypeTest.Short ||
                type == PrimitiveTypeTest.Integer ||
                type == PrimitiveTypeTest.Long ||
                type == PrimitiveTypeTest.Float ||
                type == PrimitiveTypeTest.Double) {
            return true;
        } else {
            return false;
        }
    }

    public boolean isType(TypeTest type) {
        return this == type;
    }
}
