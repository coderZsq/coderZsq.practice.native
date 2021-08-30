package play;

import org.antlr.v4.runtime.ParserRuleContext;

// 块作用域
public class BlockScopeTest extends ScopeTest {

    private static int index = 1;
    protected BlockScopeTest() {
        this.name = "block" + index++;
    }

    protected BlockScopeTest(ScopeTest enclosingScope, ParserRuleContext ctx) {
        this.name = "block" +index++;
        this.enclosingScope = enclosingScope;
        this.ctx = ctx;
    }

    @Override
    public String toString(){
        return "Block " + name;
    }
}
