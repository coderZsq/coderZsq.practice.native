package play;

import org.antlr.v4.runtime.RuleContext;
import org.antlr.v4.runtime.tree.ParseTree;
import play.PlayScriptParser.ClassDeclarationContext;
import play.PlayScriptParser.FunctionDeclarationContext;
import play.PlayScriptParser.StatementContext;
import play.PlayScriptParser.SwitchBlockStatementGroupContext;

public class SematicValidatorTest extends PlayScriptBaseListener {

    private AnnotatedTreeTest at = null;

    public SematicValidatorTest(AnnotatedTreeTest at) {
        this.at = at;
    }

    @Override
    public void exitClassDeclaration(PlayScriptParser.ClassDeclarationContext ctx) {
        if (at.enclosingFunctionOfNode(ctx) != null) {
            at.log("can not declare class inside function", ctx);
        }
    }

    @Override
    public void exitFunctionDeclaration(PlayScriptParser.FunctionDeclarationContext ctx) {
        if (ctx.typeTypeOrVoid() != null) {
            if (!hasReturnStatement(ctx)) {
                TypeTest retrunType = at.typeOfNode.get(ctx.typeTypeOrVoid());
                if (!(retrunType == VoidTypeTest.instance())) {
                    at.log("return statment expected in function", ctx);
                }
            }
        }
    }

    @Override
    public void exitStatement(PlayScriptParser.StatementContext ctx) {
        if (ctx.RETURN() != null) {
            FunctionTest function = at.enclosingFunctionOfNode(ctx);
            if (function == null) {
                at.log("return statement not in function body", ctx);
            } else if (function.isConstructor() && ctx.expression() != null) {
                at.log("can not return a value from constructor", ctx);
            }
        } else if (ctx.BREAK() != null) {
            if (!checkBreak(ctx)) {
                at.log("break statement not in loop or switch statements", ctx);
            }
        }
    }

    private boolean hasReturnStatement(ParseTree ctx) {
        boolean rtn = false;
        for (int i = 0; i < ctx.getChildCount(); i++) {
            ParseTree child = ctx.getChild(i);
            if (child instanceof StatementContext &&
                    ((StatementContext) child).RETURN() != null) {
                rtn = true;
                break;
            } else if (!(child instanceof FunctionDeclarationContext ||
                    child instanceof ClassDeclarationContext)) {
                rtn = hasReturnStatement(child);
                if (rtn) {
                    break;
                }
            }
        }
        return rtn;
    }

    private boolean checkBreak(RuleContext ctx) {
        if (ctx.parent instanceof StatementContext &&
                (((StatementContext) ctx.parent).FOR() != null ||
                        ((StatementContext) ctx.parent).WHILE() != null) ||
                ctx.parent instanceof SwitchBlockStatementGroupContext) {
            return true;
        } else if (ctx.parent == null || ctx.parent instanceof FunctionDeclarationContext) {
            return false;
        } else {
            return checkBreak(ctx.parent);
        }
    }
}