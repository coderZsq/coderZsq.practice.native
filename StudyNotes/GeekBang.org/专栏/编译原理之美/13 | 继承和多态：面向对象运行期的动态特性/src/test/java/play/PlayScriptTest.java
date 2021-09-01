package play;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.junit.Test;

public class PlayScriptTest {

    @Test
    public void test() {
        String script = "int age = 44; for(int i = 0;i<10;i++) { age = age + 2;} int i = 8;";

       PlayScriptCompilerTest compiler = new PlayScriptCompilerTest();
       AnnotatedTreeTest at = compiler.compile(script, false, false);
       if (!at.hasCompilationError()) {
           Object result = compiler.Execute(at);
           System.out.println(result);
       }
    }
}
