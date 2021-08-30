package play;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTreeWalker;

public class PlayScriptCompilerTest {

    AnnotatedTreeTest at = null;
    PlayScriptLexer lexer = null;
    PlayScriptParser parser = null;

    public AnnotatedTreeTest complie(String script, boolean verbose, boolean ast_dump) {
        at = new AnnotatedTreeTest();

        lexer = new PlayScriptLexer(CharStreams.fromString(script));
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        parser = new PlayScriptParser(tokens);
        at.ast = parser.prog();

        ParseTreeWalker walker = new ParseTreeWalker();

        TypeAndScopeScannerTest pass1 = new TypeAndScopeScannerTest(at);
        walker.walk(pass1, at.ast);

        TypeResolverTest pass2 = new TypeResolverTest(at);
        walker.walk(pass2, at.ast);

        RefResolverTest pass3 = new RefResolverTest(at);
        walker.walk(pass3, at.ast);

        TypeCheckTest pass4 = new TypeCheckTest(at);
        walker.walk(pass4, at.ast);

        return at;
    }
}
