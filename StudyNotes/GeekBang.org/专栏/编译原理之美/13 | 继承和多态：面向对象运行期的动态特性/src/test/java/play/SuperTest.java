package play;

import org.antlr.v4.runtime.ParserRuleContext;

public class SuperTest extends VariableTest {

    SuperTest(ClassTest theClass, ParserRuleContext ctx){
        super("super", theClass, ctx);
    }

    private ClassTest Class(){
        return (ClassTest) enclosingScope;
    }
}
