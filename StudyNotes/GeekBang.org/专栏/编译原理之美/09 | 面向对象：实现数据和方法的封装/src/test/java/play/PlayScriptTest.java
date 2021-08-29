package play;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.junit.Test;

public class PlayScriptTest {

    @Test
    public void test() {
        // String script = "int age = 44; for(int i = 0;i<10;i++) { age = age + 2;} int i = 8;";
        String script = "int b= 10; int myfunc(int a) {return a+b+3;} myfunc(2);";

        PlayScriptLexer lexer = new PlayScriptLexer(CharStreams.fromString(script));
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        PlayScriptParser parser = new PlayScriptParser(tokens);
        ParseTree tree = parser.prog();
        System.out.println(tree.toStringTree(parser));

        ASTEvaluatorTest visitor = new ASTEvaluatorTest();
        Integer result = (Integer) visitor.visit(tree);
        System.out.println("\nValue of : " + script);
        System.out.println(result);
    }
}
