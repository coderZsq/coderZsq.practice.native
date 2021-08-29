package play;

// 块作用域
public class BlockScopeTest extends ScopeTest {
    @Override
    public boolean containsSymbol(VariableTest variable) {
        return false;
    }
}
