package play;

import org.antlr.v4.runtime.ParserRuleContext;

import java.util.HashMap;
import java.util.Map;

public class AnnotatedTreeTest {
    protected Map<ParserRuleContext, SymbolTest> symbolOfNode = new HashMap<ParserRuleContext, SymbolTest>();
    protected Map<ParserRuleContext, ScopeTest> node2Scope = new HashMap<ParserRuleContext, ScopeTest>();
}
