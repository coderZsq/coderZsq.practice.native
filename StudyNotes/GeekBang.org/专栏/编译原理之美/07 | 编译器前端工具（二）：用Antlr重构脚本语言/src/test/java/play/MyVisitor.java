package play;

import play.PlayScriptParser.*;

public class MyVisitor extends PlayScriptBaseVisitor<Object> {

    @Override
    public Object visitStatement(PlayScriptParser.StatementContext ctx) {
        Object rtn = null;
        if (ctx.statementExpression != null) {
            rtn = visitExpression(ctx.statementExpression);
        } else if (ctx.FOR() != null) {
            ForControlContext forControl = ctx.forControl();
            // 初始化部分执行一次
            if (forControl.forInit() != null) {
                rtn = visitForInit(forControl.forInit());
            }
            while (true) {
                Boolean condition = true; // 如果没有条件判断部分, 意味着一直循环
                if (forControl.expression() != null) {
                    condition = (Boolean) visitExpression(forControl.expression());
                }
                if (condition) {
                    // 执行for的语句体
                    rtn = visitStatement(ctx.statement(0));

                    // 执行forUpdate, 通常是"i++"这样的语句, 这个执行顺序不能出错
                    if (forControl.forUpdate != null) {
                        visitExpressionList(forControl.forUpdate);
                    }
                } else {
                    break;
                }
            }
        }
        return rtn;
    }

    @Override
    public Object visitExpression(PlayScriptParser.ExpressionContext ctx) {
        Object rtn = null;
        // 二元表达式
        if (ctx.bop != null && ctx.expression().size() >= 2) {
            Object left = visitExpression(ctx.expression(0));
            Object right = visitExpression(ctx.expression(1));
            switch (ctx.bop.getType()) {
                case PlayScriptParser.ADD: //加法运算
                    rtn = add(left, right);
                    break;
                case PlayScriptParser.SUB: //减法运算
                    rtn = minus(left, right);
                    break;
                default:
                    break;
            }
        } else if (ctx.primary() != null) {
            rtn = visitPrimary(ctx.primary());
        }
        return rtn;
    }

    private Object add(Object obj1, Object obj2) {
        return ((Number) obj1).intValue() + ((Number) obj2).intValue();
    }

    private Object minus(Object obj1, Object obj2) {
        return ((Number) obj1).intValue() - ((Number) obj2).intValue();
    }

    @Override
    public Object visitPrimary(PlayScriptParser.PrimaryContext ctx) {
        Object rtn = null;
        //字面量
        if (ctx.literal() != null) {
            rtn = visitLiteral(ctx.literal());
        }
        return rtn;
    }

    @Override
    public Object visitLiteral(PlayScriptParser.LiteralContext ctx) {
        Object rtn = null;
        //整数
        if (ctx.integerLiteral() != null) {
            rtn = visitIntegerLiteral(ctx.integerLiteral());
        }
        return rtn;
    }

    @Override
    public Object visitIntegerLiteral(PlayScriptParser.IntegerLiteralContext ctx) {
        Object rtn = null;
        if (ctx.DECIMAL_LITERAL() != null) {
            rtn = Integer.valueOf(ctx.DECIMAL_LITERAL().getText());
        }
        return rtn;
    }
}
