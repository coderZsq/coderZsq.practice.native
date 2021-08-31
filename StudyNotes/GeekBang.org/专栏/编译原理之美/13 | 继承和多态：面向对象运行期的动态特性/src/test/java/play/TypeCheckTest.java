package play;

import org.antlr.v4.runtime.ParserRuleContext;
import play.PlayScriptParser.ExpressionContext;

public class TypeCheckTest extends PlayScriptBaseListener {

    private AnnotatedTreeTest at = null;

    public TypeCheckTest(AnnotatedTreeTest at) {
        this.at = at;
    }

    @Override
    public void exitVariableDeclarator(PlayScriptParser.VariableDeclaratorContext ctx) {
        if (ctx.variableInitializer() != null) {
            VariableTest variable = (VariableTest) at.symbolOfNode.get(ctx.variableDeclaratorId());
            TypeTest type1 = variable.type;
            TypeTest type2 = at.typeOfNode.get(ctx.variableInitializer());
            checkAssign(type1, type2, ctx, ctx.variableDeclaratorId(), ctx.variableInitializer());
        }
    }

    @Override
    public void exitExpression(PlayScriptParser.ExpressionContext ctx) {
        if (ctx.bop != null && ctx.expression().size() >= 2) {
            TypeTest type1 = at.typeOfNode.get(ctx.expression(0));
            TypeTest type2 = at.typeOfNode.get(ctx.expression(1));
            switch (ctx.bop.getType()) {
                case PlayScriptParser.ADD:
                    if (type1 != PrimitiveTypeTest.String && type2 != PrimitiveTypeTest.String) {
                        checkNumericOperand(type1, ctx, ctx.expression(0));
                        checkNumericOperand(type2, ctx, ctx.expression(1));
                    }
                    break;
                case PlayScriptParser.SUB:
                case PlayScriptParser.MUL:
                case PlayScriptParser.DIV:
                case PlayScriptParser.LE:
                case PlayScriptParser.LT:
                case PlayScriptParser.GE:
                case PlayScriptParser.GT:
                    checkNumericOperand(type1, ctx, ctx.expression(0));
                    checkNumericOperand(type2, ctx, ctx.expression(1));
                case PlayScriptParser.EQUAL:
                case PlayScriptParser.NOTEQUAL:
                    break;
                case PlayScriptParser.AND:
                case PlayScriptParser.OR:
                    checkBooleanOperand(type1, ctx, ctx.expression(0));
                    checkBooleanOperand(type2, ctx, ctx.expression(1));
                    break;
                case PlayScriptParser.ASSIGN:
                    checkAssign(type1, type2, ctx, ctx.expression(0), ctx.expression(1));
                    break;
                case PlayScriptParser.ADD_ASSIGN:
                case PlayScriptParser.SUB_ASSIGN:
                case PlayScriptParser.MUL_ASSIGN:
                case PlayScriptParser.DIV_ASSIGN:
                case PlayScriptParser.AND_ASSIGN:
                case PlayScriptParser.OR_ASSIGN:
                case PlayScriptParser.XOR_ASSIGN:
                case PlayScriptParser.MOD_ASSIGN:
                case PlayScriptParser.LSHIFT_ASSIGN:
                case PlayScriptParser.RSHIFT_ASSIGN:
                case PlayScriptParser.URSHIFT_ASSIGN:
                    if (PrimitiveTypeTest.isNumeric(type2)) {
                        if (!checkNumericAssign(type2, type1)) {
                            at.log("can not assign " + ctx.expression(1).getText() + " of type " + type2 + " to " + ctx.expression(0) + " of type " + type1, ctx);
                        }
                    } else {
                        at.log("operand + " + ctx.expression(1).getText() + " should be numeric。", ctx);
                    }
                    break;
            }
        }
    }

    private void checkNumericOperand(TypeTest type, PlayScriptParser.ExpressionContext exp, ExpressionContext operand) {
        if (!(PrimitiveTypeTest.isNumeric(type))) {
            at.log("operand for arithmetic operation should be numeric : " + operand.getText(), exp);
        }
    }

    private void checkBooleanOperand(TypeTest type, ExpressionContext exp, ExpressionContext operand) {
        if (!(type == PrimitiveTypeTest.Boolean)) {
            at.log("operand for logical operation should be boolean : " + operand.getText(), exp);
        }
    }


    private void checkAssign(TypeTest type1, TypeTest type2, ParserRuleContext ctx, ParserRuleContext operand1, ParserRuleContext operand2) {
        if (PrimitiveTypeTest.isNumeric(type2)) {
            if (!checkNumericAssign(type2, type1)) {
                at.log("can not assign " + operand2.getText() + " of type " + type2 + " to " + operand1.getText() + " of type " + type1, ctx);
            }
        } else if (type2 instanceof Class) {
            //TODO 检查类的兼容性
        } else if (type2 instanceof Function) {
            //TODO 检查函数的兼容性
        }
    }

    private boolean checkNumericAssign(TypeTest from, TypeTest to) {
        boolean canAssign = false;
        if (to == PrimitiveTypeTest.Double) {
            canAssign = (PrimitiveTypeTest.isNumeric(from));
        } else if (to == PrimitiveTypeTest.Float) {
            canAssign = (from == PrimitiveTypeTest.Byte ||
                    from == PrimitiveTypeTest.Short ||
                    from == PrimitiveTypeTest.Integer ||
                    from == PrimitiveTypeTest.Long ||
                    from == PrimitiveTypeTest.Float);
        } else if (to == PrimitiveTypeTest.Long) {
            canAssign = (from == PrimitiveTypeTest.Byte ||
                    from == PrimitiveTypeTest.Short ||
                    from == PrimitiveTypeTest.Integer ||
                    from == PrimitiveTypeTest.Long);
        } else if (to == PrimitiveTypeTest.Integer) {
            canAssign = (from == PrimitiveTypeTest.Byte ||
                    from == PrimitiveTypeTest.Short ||
                    from == PrimitiveTypeTest.Integer);
        } else if (to == PrimitiveTypeTest.Short) {
            canAssign = (from == PrimitiveTypeTest.Byte ||
                    from == PrimitiveTypeTest.Short);
        } else if (to == PrimitiveTypeTest.Byte) {
            canAssign = (from == PrimitiveTypeTest.Byte);
        }

        return canAssign;
    }
}