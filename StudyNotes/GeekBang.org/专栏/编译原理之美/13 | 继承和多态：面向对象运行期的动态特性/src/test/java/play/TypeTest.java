package play;

public interface TypeTest {
    public String getName(); // 类型名称

    public ScopeTest getEnclosingScope();

    public boolean isType(TypeTest type);
}
