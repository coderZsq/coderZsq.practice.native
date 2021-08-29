package play;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.junit.Test;

public class PlayScriptTest {

    @Test
    public void test() {
        String script = "int age = 44; for(int i = 0;i<10;i++) { age = age + 2;} int i = 8;";

        PlayScriptLexer lexer = new PlayScriptLexer(CharStreams.fromString(script));
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        PlayScriptParser parser = new PlayScriptParser(tokens);
        ParseTree tree = parser.blockStatement();
        System.out.println(tree.toStringTree(parser));

        ASTEvaluatorTest visitor = new ASTEvaluatorTest();
        Integer result = (Integer) visitor.visit(tree);
        System.out.println("\nValue of : " + script);
        System.out.println(result);
    }
}
