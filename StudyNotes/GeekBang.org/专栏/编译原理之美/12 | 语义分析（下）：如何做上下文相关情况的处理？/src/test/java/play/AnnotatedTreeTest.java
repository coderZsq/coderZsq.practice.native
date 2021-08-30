package play;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.ParseTree;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class AnnotatedTreeTest {
    // AST
    protected ParseTree ast = null;

    // 解析出来的所有类型, 包括类和函数
    protected List<TypeTest> types = new LinkedList<TypeTest>();

    // AST 节点对应的 Symbol
    protected Map<ParserRuleContext, SymbolTest> symbolOfNode = new HashMap<ParserRuleContext, SymbolTest>();

    // AST 节点对应的 Scope, 如 for、函数调用会启动新的 Scope
    protected Map<ParserRuleContext, ScopeTest> node2Scope = new HashMap<ParserRuleContext, ScopeTest>();

    // 每个节点推断出来的类型
    protected Map<ParserRuleContext, TypeTest> typeOfNode = new HashMap<ParserRuleContext, TypeTest>();

    // 命名空间, 作用域的根节点
    NameSpaceTest nameSpace = null;

    public ScopeTest enclosingScopeOfNode(PlayScriptParser.FunctionCallContext ctx) {
        return null;
    }

    public ClassTest lookupClass(ScopeTest scope, String idName) {
        return null;
    }

    public void log(String message, ParserRuleContext ctx) {
    }
}
