package play;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.junit.Test;

public class PlayScriptTest {

    @Test
    public void test() {
        String script = "1 + 2 + 3 - 4;";

        PlayScriptLexer lexer = new PlayScriptLexer(CharStreams.fromString(script));
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        PlayScriptParser parser = new PlayScriptParser(tokens);
        ParseTree tree = parser.statement();
        // System.out.println(tree.toStringTree(parser));

        MyVisitor visitor = new MyVisitor();
        Integer result = (Integer) visitor.visit(tree);
        System.out.println("\nValue of : " + script);
        System.out.println(result);
    }
}
