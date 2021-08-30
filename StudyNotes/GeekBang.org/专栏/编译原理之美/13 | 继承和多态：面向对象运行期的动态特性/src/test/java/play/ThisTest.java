package play;

import org.antlr.v4.runtime.ParserRuleContext;

public class ThisTest extends VariableTest {

    ThisTest(ClassTest theClass, ParserRuleContext ctx) {
        super("this", theClass, ctx);
    }

    private ClassTest Class() {
        return (ClassTest) enclosingScope;
    }
}
