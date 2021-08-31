package play;

import org.antlr.v4.runtime.ParserRuleContext;

import java.util.Stack;

public class TypeAndScopeScannerTest extends PlayScriptBaseListener {

    private AnnotatedTreeTest at = null;
    private Stack<ScopeTest> scopeStack = new Stack<>();

    public TypeAndScopeScannerTest(AnnotatedTreeTest at) {
        this.at = at;
    }

    private ScopeTest pushScope(ScopeTest scope, ParserRuleContext ctx) {
        at.node2Scope.put(ctx, scope);
        scope.ctx = ctx;

        scopeStack.push(scope);
        return scope;
    }

    private void popScope() {
        scopeStack.pop();
    }

    private ScopeTest currentScope() {
        if (scopeStack.size() > 0) {
            return scopeStack.peek();
        } else {
            return null;
        }
    }

    @Override
    public void enterProg(PlayScriptParser.ProgContext ctx) {
        NameSpaceTest scope = new NameSpaceTest("", currentScope(), ctx);
        at.nameSpace = scope;
        pushScope(scope, ctx);
    }

    @Override
    public void exitProg(PlayScriptParser.ProgContext ctx) {
        popScope();
    }

    @Override
    public void enterBlock(PlayScriptParser.BlockContext ctx) {
        if (!(ctx.parent instanceof PlayScriptParser.FunctionBodyContext)) {
            BlockScopeTest scope = new BlockScopeTest(currentScope(), ctx);
            currentScope().addSymbol(scope);
            pushScope(scope, ctx);
        }
    }

    @Override
    public void exitBlock(PlayScriptParser.BlockContext ctx) {
        if (!(ctx.parent instanceof PlayScriptParser.FunctionBodyContext)) {
            popScope();
        }
    }

    @Override
    public void enterStatement(PlayScriptParser.StatementContext ctx) {
        if (ctx.FOR() != null) {
            BlockScopeTest scope = new BlockScopeTest(currentScope(), ctx);
            currentScope().addSymbol(scope);
            pushScope(scope, ctx);
        }
    }

    @Override
    public void exitStatement(PlayScriptParser.StatementContext ctx) {
        if (ctx.FOR() != null) {
            popScope();
        }
    }

    @Override
    public void enterFunctionDeclaration(PlayScriptParser.FunctionDeclarationContext ctx) {
        String idName = ctx.IDENTIFIER().getText();
        FunctionTest function = new FunctionTest(idName, currentScope(), ctx);
        at.types.add(function);
        currentScope().addSymbol(function);
        pushScope(function, ctx);
    }

    @Override
    public void exitFunctionDeclaration(PlayScriptParser.FunctionDeclarationContext ctx) {
        popScope();
    }

    @Override
    public void enterClassDeclaration(PlayScriptParser.ClassDeclarationContext ctx) {
        String idName = ctx.IDENTIFIER().getText();
        ClassTest theClass = new ClassTest(idName, ctx);
        at.types.add(theClass);
        if (at.lookupClass(currentScope(), idName) != null) {
            at.log("duplicate class name:" + idName, ctx);
        }
        currentScope().addSymbol(theClass);
        pushScope(theClass, ctx);
    }

    @Override
    public void exitClassDeclaration(PlayScriptParser.ClassDeclarationContext ctx) {
        popScope();
    }
}
