package play;

import org.antlr.v4.runtime.ParserRuleContext;

import java.util.HashMap;
import java.util.Map;

public class AnnotatedTreeTest {
    protected Map<ParserRuleContext, TypeTest> typeOfNode = new HashMap<ParserRuleContext, TypeTest>();
    protected Map<ParserRuleContext, SymbolTest> symbolOfNode = new HashMap<ParserRuleContext, SymbolTest>();
    protected Map<ParserRuleContext, ScopeTest> node2Scope = new HashMap<ParserRuleContext, ScopeTest>();

    public ScopeTest enclosingScopeOfNode(PlayScriptParser.FunctionCallContext ctx) {
        return null;
    }

    public ClassTest lookupClass(ScopeTest scope, String idName) {
        return null;
    }

    public void log(String s, PlayScriptParser.FunctionCallContext ctx) {
    }
}
