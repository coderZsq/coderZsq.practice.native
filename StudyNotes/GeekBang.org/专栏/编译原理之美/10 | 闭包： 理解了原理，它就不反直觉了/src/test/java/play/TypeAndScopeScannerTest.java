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
}
