package play;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.RuleContext;
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
    protected List<CompilationLogTest> logs = new LinkedList<>();
    protected Map<FunctionTest, FunctionTest> thisConstructorRef = new HashMap<>();
    protected Map<FunctionTest, FunctionTest> superConstructorRef = new HashMap<>();
    // 命名空间, 作用域的根节点
    NameSpaceTest nameSpace = null;

    protected AnnotatedTreeTest() {

    }

    protected void log(String message, int type, ParserRuleContext ctx) {
        CompilationLogTest log = new CompilationLogTest();
        log.ctx = ctx;
        log.message = message;
        log.line = ctx.getStart().getLine();
        log.positionInLine = ctx.getStart().getStartIndex();
        log.type = type;

        logs.add(log);

        System.out.println(log);
    }

    public void log(String message, ParserRuleContext ctx) {
        this.log(message, CompilationLogTest.ERROR, ctx);
    }

    protected boolean hasCompilationError() {
        for (CompilationLogTest log : logs) {
            if (log.type == CompilationLogTest.ERROR) {
                return true;
            }
        }
        return false;
    }

    protected VariableTest lookupVariable(ScopeTest scope, String idName) {
        VariableTest rtn = scope.getVariable(idName);
        if (rtn == null && scope.enclosingScope != null) {
            rtn = lookupVariable(scope.enclosingScope, idName);
        }
        return rtn;
    }

    protected ClassTest lookupClass(ScopeTest scope, String idName) {
        ClassTest rtn = scope.getClass(idName);
        if (rtn == null && scope.enclosingScope != null) {
            rtn = lookupClass(scope.enclosingScope, idName);
        }
        return rtn;
    }

    protected TypeTest lookupType(String idName) {
        TypeTest rtn = null;
        for (TypeTest type : types) {
            if (type.getName().equals(idName)) {
                rtn = type;
                break;
            }
        }
        return rtn;
    }

    protected FunctionTest lookupFunction(ScopeTest scope, String idName, List<TypeTest> paramTypes) {
        FunctionTest rtn = scope.getFunction(idName, paramTypes);
        if (rtn == null && scope.enclosingScope != null) {
            rtn = lookupFunction(scope.enclosingScope, idName, paramTypes);
        }
        return rtn;
    }

    protected VariableTest lookupFunctionVariable(ScopeTest scope, String idName, List<TypeTest> paramTypes) {
        VariableTest rtn = scope.getFunctionVariable(idName, paramTypes);
        if (rtn == null && scope.enclosingScope != null) {
            rtn = lookupFunctionVariable(scope.enclosingScope, idName, paramTypes);
        }
        return rtn;
    }

    protected FunctionTest lookupFunction(ScopeTest scope, String name) {
        FunctionTest rtn = null;
        if (scope instanceof ClassTest) {
            rtn = getMethodOnlyByName((ClassTest) scope, name);
        } else {
            rtn = getFunctionOnlyByName(scope, name);
        }
        if (rtn == null && scope.enclosingScope != null) {
            rtn = lookupFunction(scope.enclosingScope, name);
        }
        return rtn;
    }

    private FunctionTest getMethodOnlyByName(ClassTest theClass, String name) {
        FunctionTest rtn = getFunctionOnlyByName(theClass, name);
        if (rtn == null && theClass.getParentClass() != null) {
            rtn = getMethodOnlyByName(theClass.getParentClass(), name);
        }
        return rtn;
    }

    private FunctionTest getFunctionOnlyByName(ScopeTest scope, String name) {
        for (SymbolTest s : scope.symbols) {
            if (s instanceof FunctionTest && s.name.equals(name)) {
                return (FunctionTest) s;
            }
        }
        return null;
    }

    public ScopeTest enclosingScopeOfNode(ParserRuleContext node) {
        ScopeTest rtn = null;
        ParserRuleContext parent = node.getParent();
        if (parent != null) {
            rtn = node2Scope.get(parent);
            if (rtn == null) {
                rtn = enclosingScopeOfNode(parent);
            }
        }
        return rtn;
    }

    public FunctionTest enclosingFunctionOfNode(RuleContext ctx) {
        if (ctx.parent instanceof PlayScriptParser.FunctionDeclarationContext) {
            return (FunctionTest) node2Scope.get(ctx.parent);
        } else if (ctx.parent == null) {
            return null;
        } else {
            return enclosingFunctionOfNode(ctx.parent);
        }
    }

    public ClassTest enclosingClassOfNode(RuleContext ctx) {
        if (ctx.parent instanceof PlayScriptParser.ClassDeclarationContext) {
            return (ClassTest) node2Scope.get(ctx.parent);
        } else if (ctx.parent == null) {
            return null;
        } else {
            return enclosingClassOfNode(ctx.parent);
        }
    }

    public String getScopeTreeString() {
        StringBuffer sb = new StringBuffer();
        scopeToString(sb, nameSpace, "");
        return sb.toString();
    }

    private void scopeToString(StringBuffer sb, ScopeTest scope, String indent) {
        sb.append(indent).append(scope).append("\n");
        for (SymbolTest symbol : scope.symbols) {
            if (symbol instanceof ScopeTest) {
                scopeToString(sb, (ScopeTest) symbol, indent + "\t");
            } else {
                sb.append(indent).append("\t").append(symbol).append("\n");
            }
        }
    }
}
