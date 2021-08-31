package play;

import org.antlr.v4.runtime.ParserRuleContext;

public class CompilationLogTest {
    protected String message = null;
    protected int line;
    protected int positionInLine;
    protected ParserRuleContext ctx;
    protected int type = INFO;

    public static int INFO = 0;
    public static int WARNING = 1;
    public static int ERROR = 2;

    @Override
    public String toString() {
        return message + "@" + line + ":" + positionInLine;
    }
}
