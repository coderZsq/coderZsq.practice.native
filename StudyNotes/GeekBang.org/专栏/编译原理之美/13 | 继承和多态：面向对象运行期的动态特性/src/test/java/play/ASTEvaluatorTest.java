package play;

import play.PlayScriptParser.*;

import java.util.LinkedList;
import java.util.List;
import java.util.Stack;

public class ASTEvaluatorTest extends PlayScriptBaseVisitor<Object> {

    protected boolean traceStackFrame = false;
    protected boolean traceFunctionCall = false;
    private AnnotatedTreeTest at = null;
    private Stack<StackFrameTest> stack = new Stack<StackFrameTest>();

    public ASTEvaluatorTest(AnnotatedTreeTest at) {
        this.at = at;
    }

    private void pushStack(StackFrameTest frame) {
        if (stack.size() > 0) {
            for (int i = stack.size() - 1; i > 0; i--) {
                StackFrameTest f = stack.get(i);
                if (f.scope.enclosingScope == frame.scope.enclosingScope) {
                    frame.parentFrame = f.parentFrame;
                    break;
                } else if (f.scope == frame.scope.enclosingScope) {
                    frame.parentFrame = f;
                    break;
                } else if (frame.object instanceof FunctionObjectTest) {
                    FunctionObjectTest functionObject = (FunctionObjectTest) frame.object;
                    if (functionObject.receiver != null && functionObject.receiver.enclosingScope == f.scope) {
                        frame.parentFrame = f;
                        break;
                    }
                }
            }
            if (frame.parentFrame == null) {
                frame.parentFrame = stack.peek();
            }
        }
        stack.push(frame);

        if (traceStackFrame) {
            dumpStackFrame();
        }
    }

    private void popStack() {
        stack.pop();
    }

    private void dumpStackFrame() {
        System.out.println("\nStack Frames ----------------");
        for (StackFrameTest frame : stack) {
            System.out.println(frame);
        }
        System.out.println("-----------------------------\n");
    }

    private LValueTest getLValue(VariableTest variable) {
        StackFrameTest f = stack.peek(); // 获取栈顶的帧

        PlayObjectTest valueContainer = null;
        while (f != null) {
            // 看变量是否属于当前栈帧里
            if (f.scope.containsSymbol(variable)) {
                valueContainer = f.object;
                break;
            }
            // 从上一级 scope 对应的栈帧里去找
            f = f.parentFrame;
        }

        if (valueContainer == null) {
            f = stack.peek();
            while (f != null) {
                if (f.contains(variable)) {
                    valueContainer = f.object;
                    break;
                }
                f = f.parentFrame;
            }
        }

        MyLValueTest lValue = new MyLValueTest(valueContainer, variable);
        return lValue;
    }

    private void getClosureValues(FunctionTest function, PlayObjectTest valueContainer) {
        if (function.closureVariables != null) {
            for (VariableTest var : function.closureVariables) {
                // 现在还可以从栈里取, 退出函数以后就不行了
                LValueTest lValue = getLValue(var);
                Object value = lValue.getValue();
                valueContainer.fields.put(var, value);
            }
        }
    }

    private void getClosureValues(ClassObjectTest classObject) {
        PlayObjectTest tempObject = new PlayObjectTest();
        for (VariableTest v : classObject.fields.keySet()) {
            if (v.type instanceof FunctionTypeTest) {
                Object object = classObject.fields.get(v);
                if (object != null) {
                    FunctionObjectTest functionObject = (FunctionObjectTest) object;
                    getClosureValues(functionObject.function, tempObject);
                }
            }
        }
        classObject.fields.putAll(tempObject.fields);
    }

    // 从父类到子类层层执行缺省的初始化方法, 即不带参数的初始化方法
    protected ClassObjectTest createAndInitClassObject(ClassTest theClass) {
        ClassObjectTest obj = new ClassObjectTest();
        obj.type = theClass;

        Stack<ClassTest> ancestorChain = new Stack<>();

        // 从上到下执行缺省的初始化方法
        ancestorChain.push(theClass);
        while (theClass.getParentClass() != null) {
            ancestorChain.push(theClass.getParentClass());
            theClass = theClass.getParentClass();
        }

        // 执行缺省的初始化方法
        StackFrameTest frame = new StackFrameTest(obj);
        pushStack(frame);
        while (ancestorChain.size() > 0) {
            ClassTest c = ancestorChain.pop();
            defaultObjectInit(c, obj);
        }
        popStack();

        return obj;
    }

    private void defaultObjectInit(ClassTest theClass, ClassObjectTest obj) {
        for (SymbolTest symbol : theClass.symbols) {
            if (symbol instanceof VariableTest) {
                obj.fields.put((VariableTest) symbol, null);
            }
        }
        ClassBodyContext ctx = ((ClassDeclarationContext) theClass.ctx).classBody();
        visitClassBody(ctx);
    }

    private void println(FunctionCallContext ctx) {
        if (ctx.expressionList() != null) {
            Object value = visitExpressionList(ctx.expressionList());
            if (value instanceof LValueTest) {
                value = ((LValue) value).getValue();
            }
            System.out.println(value);
        } else {
            System.out.println();
        }
    }

    private Object add(Object obj1, Object obj2, TypeTest targetType) {
        Object rtn = null;
        if (targetType == PrimitiveTypeTest.String) {
            rtn = String.valueOf(obj1) + String.valueOf(obj2);
        } else if (targetType == PrimitiveTypeTest.Integer) {
            rtn = ((Number) obj1).intValue() + ((Number) obj2).intValue();
        } else if (targetType == PrimitiveTypeTest.Float) {
            rtn = ((Number) obj1).floatValue() + ((Number) obj2).floatValue();
        } else if (targetType == PrimitiveTypeTest.Long) {
            rtn = ((Number) obj1).longValue() + ((Number) obj2).longValue();
        } else if (targetType == PrimitiveTypeTest.Double) {
            rtn = ((Number) obj1).doubleValue() + ((Number) obj2).doubleValue();
        } else if (targetType == PrimitiveTypeTest.Short) {
            rtn = ((Number) obj1).shortValue() + ((Number) obj2).shortValue();
        } else {
            System.out.println("unsupported add operation");
        }
        return rtn;
    }

    private Object minus(Object obj1, Object obj2, TypeTest targetType) {
        Object rtn = null;
        if (targetType == PrimitiveTypeTest.Integer) {
            rtn = ((Number) obj1).intValue() - ((Number) obj2).intValue();
        } else if (targetType == PrimitiveTypeTest.Float) {
            rtn = ((Number) obj1).floatValue() - ((Number) obj2).floatValue();
        } else if (targetType == PrimitiveTypeTest.Long) {
            rtn = ((Number) obj1).longValue() - ((Number) obj2).longValue();
        } else if (targetType == PrimitiveTypeTest.Double) {
            rtn = ((Number) obj1).doubleValue() - ((Number) obj2).doubleValue();
        } else if (targetType == PrimitiveTypeTest.Short) {
            rtn = ((Number) obj1).shortValue() - ((Number) obj2).shortValue();
        }
        return rtn;
    }

    private Object mul(Object obj1, Object obj2, TypeTest targetType) {
        Object rtn = null;
        if (targetType == PrimitiveTypeTest.Integer) {
            rtn = ((Number) obj1).intValue() * ((Number) obj2).intValue();
        } else if (targetType == PrimitiveTypeTest.Float) {
            rtn = ((Number) obj1).floatValue() * ((Number) obj2).floatValue();
        } else if (targetType == PrimitiveTypeTest.Long) {
            rtn = ((Number) obj1).longValue() * ((Number) obj2).longValue();
        } else if (targetType == PrimitiveTypeTest.Double) {
            rtn = ((Number) obj1).doubleValue() * ((Number) obj2).doubleValue();
        } else if (targetType == PrimitiveTypeTest.Short) {
            rtn = ((Number) obj1).shortValue() * ((Number) obj2).shortValue();
        }

        return rtn;
    }

    private Object div(Object obj1, Object obj2, TypeTest targetType) {
        Object rtn = null;
        if (targetType == PrimitiveTypeTest.Integer) {
            rtn = ((Number) obj1).intValue() / ((Number) obj2).intValue();
        } else if (targetType == PrimitiveTypeTest.Float) {
            rtn = ((Number) obj1).floatValue() / ((Number) obj2).floatValue();
        } else if (targetType == PrimitiveTypeTest.Long) {
            rtn = ((Number) obj1).longValue() / ((Number) obj2).longValue();
        } else if (targetType == PrimitiveTypeTest.Double) {
            rtn = ((Number) obj1).doubleValue() / ((Number) obj2).doubleValue();
        } else if (targetType == PrimitiveTypeTest.Short) {
            rtn = ((Number) obj1).shortValue() / ((Number) obj2).shortValue();
        }

        return rtn;
    }

    private Boolean EQ(Object obj1, Object obj2, TypeTest targetType) {
        Boolean rtn = null;
        if (targetType == PrimitiveTypeTest.Integer) {
            rtn = ((Number) obj1).intValue() == ((Number) obj2).intValue();
        } else if (targetType == PrimitiveTypeTest.Float) {
            rtn = ((Number) obj1).floatValue() == ((Number) obj2).floatValue();
        } else if (targetType == PrimitiveTypeTest.Long) {
            rtn = ((Number) obj1).longValue() == ((Number) obj2).longValue();
        } else if (targetType == PrimitiveTypeTest.Double) {
            rtn = ((Number) obj1).doubleValue() == ((Number) obj2).doubleValue();
        } else if (targetType == PrimitiveTypeTest.Short) {
            rtn = ((Number) obj1).shortValue() == ((Number) obj2).shortValue();
        } else {
            rtn = obj1 == obj2;
        }

        return rtn;
    }

    private Object GE(Object obj1, Object obj2, TypeTest targetType) {
        Object rtn = null;
        if (targetType == PrimitiveTypeTest.Integer) {
            rtn = ((Number) obj1).intValue() >= ((Number) obj2).intValue();
        } else if (targetType == PrimitiveTypeTest.Float) {
            rtn = ((Number) obj1).floatValue() >= ((Number) obj2).floatValue();
        } else if (targetType == PrimitiveTypeTest.Long) {
            rtn = ((Number) obj1).longValue() >= ((Number) obj2).longValue();
        } else if (targetType == PrimitiveTypeTest.Double) {
            rtn = ((Number) obj1).doubleValue() >= ((Number) obj2).doubleValue();
        } else if (targetType == PrimitiveTypeTest.Short) {
            rtn = ((Number) obj1).shortValue() >= ((Number) obj2).shortValue();
        }

        return rtn;
    }

    private Object GT(Object obj1, Object obj2, TypeTest targetType) {
        Object rtn = null;
        if (targetType == PrimitiveTypeTest.Integer) {
            rtn = ((Number) obj1).intValue() > ((Number) obj2).intValue();
        } else if (targetType == PrimitiveTypeTest.Float) {
            rtn = ((Number) obj1).floatValue() > ((Number) obj2).floatValue();
        } else if (targetType == PrimitiveTypeTest.Long) {
            rtn = ((Number) obj1).longValue() > ((Number) obj2).longValue();
        } else if (targetType == PrimitiveTypeTest.Double) {
            rtn = ((Number) obj1).doubleValue() > ((Number) obj2).doubleValue();
        } else if (targetType == PrimitiveTypeTest.Short) {
            rtn = ((Number) obj1).shortValue() > ((Number) obj2).shortValue();
        }

        return rtn;
    }

    private Object LE(Object obj1, Object obj2, TypeTest targetType) {
        Object rtn = null;
        if (targetType == PrimitiveTypeTest.Integer) {
            rtn = ((Number) obj1).intValue() <= ((Number) obj2).intValue();
        } else if (targetType == PrimitiveTypeTest.Float) {
            rtn = ((Number) obj1).floatValue() <= ((Number) obj2).floatValue();
        } else if (targetType == PrimitiveTypeTest.Long) {
            rtn = ((Number) obj1).longValue() <= ((Number) obj2).longValue();
        } else if (targetType == PrimitiveTypeTest.Double) {
            rtn = ((Number) obj1).doubleValue() <= ((Number) obj2).doubleValue();
        } else if (targetType == PrimitiveTypeTest.Short) {
            rtn = ((Number) obj1).shortValue() <= ((Number) obj2).shortValue();
        }

        return rtn;
    }

    private Object LT(Object obj1, Object obj2, TypeTest targetType) {
        Object rtn = null;
        if (targetType == PrimitiveTypeTest.Integer) {
            rtn = ((Number) obj1).intValue() < ((Number) obj2).intValue();
        } else if (targetType == PrimitiveTypeTest.Float) {
            rtn = ((Number) obj1).floatValue() < ((Number) obj2).floatValue();
        } else if (targetType == PrimitiveTypeTest.Long) {
            rtn = ((Number) obj1).longValue() < ((Number) obj2).longValue();
        } else if (targetType == PrimitiveTypeTest.Double) {
            rtn = ((Number) obj1).doubleValue() < ((Number) obj2).doubleValue();
        } else if (targetType == PrimitiveTypeTest.Short) {
            rtn = ((Number) obj1).shortValue() < ((Number) obj2).shortValue();
        }

        return rtn;
    }

    @Override
    public Object visitBlock(BlockContext ctx) {
        BlockScopeTest scope = (BlockScopeTest) at.node2Scope.get(ctx);
        if (scope != null) {
            StackFrameTest frame = new StackFrameTest(scope);
            pushStack(frame);
        }
        Object rtn = visitBlockStatements(ctx.blockStatements());
        if (scope != null) {
            popStack();
        }
        return rtn;
    }

    @Override
    public Object visitBlockStatements(BlockStatementsContext ctx) {
        Object rtn = null;
        for (BlockStatementContext child : ctx.blockStatement()) {
            rtn = visitBlockStatement(child);
            if (rtn instanceof BreakObjectTest) {
                break;
            } else if (rtn instanceof ReturnObjectTest) {
                break;
            }
        }
        return rtn;
    }

    @Override
    public Object visitBlockStatement(BlockStatementContext ctx) {
        Object rtn = null;
        if (ctx.variableDeclarators() != null) {
            rtn = visitVariableDeclarators(ctx.variableDeclarators());
        } else if (ctx.statement() != null) {
            rtn = visitStatement(ctx.statement());
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
            Object leftObject = left;
            Object rightObject = right;

            if (left instanceof LValueTest) {
                leftObject = ((LValueTest) left).getValue();
            }
            if (right instanceof LValueTest) {
                rightObject = ((LValueTest) right).getValue();
            }

            TypeTest type = at.typeOfNode.get(ctx);

            TypeTest type1 = at.typeOfNode.get(ctx.expression(0));
            TypeTest type2 = at.typeOfNode.get(ctx.expression(1));

            switch (ctx.bop.getType()) {
                case PlayScriptParser.ADD: // 加法运损
                    rtn = add(leftObject, rightObject, type);
                    break;
                case PlayScriptParser.SUB: // 减法运算
                    rtn = minus(leftObject, rightObject, type);
                    break;
                case PlayScriptParser.MUL:
                    rtn = mul(leftObject, rightObject, type);
                    break;
                case PlayScriptParser.DIV:
                    rtn = div(leftObject, rightObject, type);
                    break;
                case PlayScriptParser.EQUAL:
                    rtn = EQ(leftObject, rightObject, PrimitiveTypeTest.getUpperType(type1, type2));
                    break;
                case PlayScriptParser.NOTEQUAL:
                    rtn = !EQ(leftObject, rightObject, PrimitiveTypeTest.getUpperType(type1, type2));
                    break;
                case PlayScriptParser.LE:
                    rtn = LE(leftObject, rightObject, PrimitiveTypeTest.getUpperType(type1, type2));
                    break;
                case PlayScriptParser.LT:
                    rtn = LT(leftObject, rightObject, PrimitiveTypeTest.getUpperType(type1, type2));
                    break;
                case PlayScriptParser.GE:
                    rtn = GE(leftObject, rightObject, PrimitiveTypeTest.getUpperType(type1, type2));
                    break;
                case PlayScriptParser.GT:
                    rtn = GT(leftObject, rightObject, PrimitiveTypeTest.getUpperType(type1, type2));
                    break;

                case PlayScriptParser.AND:
                    rtn = (Boolean) leftObject && (Boolean) rightObject;
                    break;
                case PlayScriptParser.OR:
                    rtn = (Boolean) leftObject || (Boolean) rightObject;
                    break;
                case PlayScriptParser.ASSIGN:
                    if (left instanceof LValue) {
                        //((LValue) left).setValue(right);
                        ((LValue) left).setValue(rightObject);
                        rtn = right;
                    } else {
                        System.out.println("Unsupported feature during assignment");
                    }
                    break;

                default:
                    break;
            }
        } else if (ctx.primary() != null) {
            rtn = visitPrimary(ctx.primary());
        } else if (ctx.bop != null && ctx.bop.getType() == PlayScriptParser.DOT) {
            Object leftObject = visitExpression(ctx.expression(0));
            if (leftObject instanceof LValue) {
                Object value = ((LValueTest) leftObject).getValue();
                if (value instanceof ClassObjectTest) {
                    ClassObjectTest valueContainer = (ClassObjectTest) value;
                    VariableTest leftVar = (VariableTest) at.symbolOfNode.get(ctx.expression(0));
                    if (ctx.IDENTIFIER() != null) {
                        VariableTest variable = (VariableTest) at.symbolOfNode.get(ctx);
                        if (!(leftVar instanceof ThisTest || leftVar instanceof SuperTest)) {
                            variable = at.lookupVariable(valueContainer.type, variable.getName());
                        }
                        LValueTest lValue = new MyLValueTest(valueContainer, variable);
                        rtn = lValue;
                    } else if (ctx.functionCall() != null) {
                        if (traceFunctionCall) {
                            System.out.println("\n>>MethodCall : " + ctx.getText());
                        }
                        rtn = methodCall(valueContainer, ctx.functionCall(), (leftVar instanceof SuperTest));
                    }
                }
            } else {
                System.out.println("Expecting an Object Reference");
            }
        } else if (ctx.primary() != null) {
            rtn = visitPrimary(ctx.primary());
        } else if (ctx.postfix != null) {
            Object value = visitExpression(ctx.expression(0));
            LValueTest lValue = null;
            TypeTest type = at.typeOfNode.get(ctx.expression(0));
            if (value instanceof LValueTest) {
                lValue = (LValueTest) value;
                value = lValue.getValue();
            }
            switch (ctx.postfix.getType()) {
                case PlayScriptParser.INC:
                    if (type == PrimitiveTypeTest.Integer) {
                        lValue.setValue((Integer) value + 1);
                    } else {
                        lValue.setValue((Long) value + 1);
                    }
                    rtn = value;
                    break;
                case PlayScriptParser.DEC:
                    if (type == PrimitiveTypeTest.Integer) {
                        lValue.setValue((Integer) value - 1);
                    } else {
                        lValue.setValue((long) value - 1);
                    }
                    rtn = value;
                    break;
                default:
                    break;
            }
        } else if (ctx.prefix != null) {
            Object value = visitExpression(ctx.expression(0));
            LValueTest lValue = null;
            TypeTest type = at.typeOfNode.get(ctx.expression(0));
            if (value instanceof LValueTest) {
                lValue = (LValueTest) value;
                value = lValue.getValue();
            }
            switch (ctx.prefix.getType()) {
                case PlayScriptParser.INC:
                    if (type == PrimitiveTypeTest.Integer) {
                        rtn = (Integer) value + 1;
                    } else {
                        rtn = (Long) value + 1;
                    }
                    lValue.setValue(rtn);
                    break;
                case PlayScriptParser.DEC:
                    if (type == PrimitiveTypeTest.Integer) {
                        rtn = (Integer) value - 1;
                    } else {
                        rtn = (Long) value - 1;
                    }
                    lValue.setValue(rtn);
                    break;
                case PlayScriptParser.BANG:
                    rtn = !((Boolean) value);
                    break;
                default:
                    break;
            }
        } else if (ctx.functionCall() != null) {
            rtn = visitFunctionCall(ctx.functionCall());
        }
        return rtn;
    }

    @Override
    public Object visitExpressionList(ExpressionListContext ctx) {
        Object rtn = null;
        for (ExpressionContext child : ctx.expression()) {
            rtn = visitExpression(child);
        }
        return rtn;
    }

    @Override
    public Object visitForInit(ForInitContext ctx) {
        Object rtn = null;
        if (ctx.variableDeclarators() != null) {
            rtn = visitVariableDeclarators(ctx.variableDeclarators());
        } else if (ctx.expressionList() != null) {
            rtn = visitExpressionList(ctx.expressionList());
        }
        return rtn;
    }

    @Override
    public Object visitLiteral(LiteralContext ctx) {
        Object rtn = null;
        //整数
        if (ctx.integerLiteral() != null) {
            rtn = visitIntegerLiteral(ctx.integerLiteral());
        } else if (ctx.floatLiteral() != null) {
            rtn = visitFloatLiteral(ctx.floatLiteral());
        } else if (ctx.BOOL_LITERAL() != null) {
            if (ctx.BOOL_LITERAL().getText().equals("true")) {
                rtn = Boolean.TRUE;
            } else {
                rtn = Boolean.FALSE;
            }
        } else if (ctx.STRING_LITERAL() != null) {
            String withQuotationMark = ctx.STRING_LITERAL().getText();
            rtn = withQuotationMark.substring(1, withQuotationMark.length() - 1);
        } else if (ctx.CHAR_LITERAL() != null) {
            rtn = ctx.CHAR_LITERAL().getText().charAt(0);
        } else if (ctx.NULL_LITERAL() != null) {
            rtn = NullObject.instance();
        }
        return rtn;
    }

    @Override
    public Object visitIntegerLiteral(IntegerLiteralContext ctx) {
        Object rtn = null;
        if (ctx.DECIMAL_LITERAL() != null) {
            rtn = Integer.valueOf(ctx.DECIMAL_LITERAL().getText());
        }
        return rtn;
    }

    @Override
    public Object visitFloatLiteral(FloatLiteralContext ctx) {
        return Float.valueOf(ctx.getText());
    }

    @Override
    public Object visitParExpression(ParExpressionContext ctx) {
        return visitExpression(ctx.expression());
    }

    @Override
    public Object visitPrimary(PlayScriptParser.PrimaryContext ctx) {
        Object rtn = null;
        //字面量
        if (ctx.literal() != null) {
            rtn = visitLiteral(ctx.literal());
        } else if (ctx.IDENTIFIER() != null) {
            SymbolTest symbol = at.symbolOfNode.get(ctx);
            if (symbol instanceof VariableTest) {
                rtn = getLValue((VariableTest) symbol);
            } else if (symbol instanceof FunctionTest) {
                FunctionObjectTest obj = new FunctionObjectTest((FunctionTest) symbol);
                rtn = obj;
            }
        } else if (ctx.expression() != null) {
            rtn = visitExpression(ctx.expression());
        } else if (ctx.THIS() != null) {
            ThisTest thisRef = (ThisTest) at.symbolOfNode.get(ctx);
            rtn = getLValue(thisRef);
        } else if (ctx.SUPER() != null) {
            SuperTest superRef = (SuperTest) at.symbolOfNode.get(ctx);
            rtn = getLValue(superRef);
        }
        return rtn;
    }

    @Override
    public Object visitPrimitiveType(PrimitiveTypeContext ctx) {
        Object rtn = null;
        if (ctx.INT() != null) {
            rtn = PlayScriptParser.INT;
        } else if (ctx.LONG() != null) {
            rtn = PlayScriptParser.LONG;
        } else if (ctx.FLOAT() != null) {
            rtn = PlayScriptParser.FLOAT;
        } else if (ctx.DOUBLE() != null) {
            rtn = PlayScriptParser.DOUBLE;
        } else if (ctx.BOOLEAN() != null) {
            rtn = PlayScriptParser.BOOLEAN;
        } else if (ctx.CHAR() != null) {
            rtn = PlayScriptParser.CHAR;
        } else if (ctx.SHORT() != null) {
            rtn = PlayScriptParser.SHORT;
        } else if (ctx.BYTE() != null) {
            rtn = PlayScriptParser.BYTE;
        }
        return rtn;
    }

    @Override
    public Object visitStatement(PlayScriptParser.StatementContext ctx) {
        Object rtn = null;
        if (ctx.statementExpression != null) {
            rtn = visitExpression(ctx.statementExpression);
        } else if (ctx.IF() != null) {
            Boolean condition = (Boolean) visitParExpression(ctx.parExpression());
            if (Boolean.TRUE == condition) {
                rtn = visitStatement(ctx.statement(0));
            } else if (ctx.ELSE() != null) {
                rtn = visitStatement(ctx.statement(1));
            }
        } else if (ctx.WHILE() != null) {
            if (ctx.parExpression().expression() != null && ctx.statement(0) != null) {
                while (true) {
                    Boolean condition = true;
                    Object value = visitExpression(ctx.parExpression().expression());
                    if (value instanceof LValueTest) {
                        condition = (Boolean) ((LValueTest) value).getValue();
                    } else {
                        condition = (Boolean) value;
                    }
                    if (condition) {
                        if (condition) {
                            rtn = visitStatement(ctx.statement(0));
                            if (rtn instanceof BreakObjectTest) {
                                rtn = null;
                                break;
                            } else if (rtn instanceof ReturnObjectTest) {
                                break;
                            }
                        }
                    } else {
                        break;
                    }
                }
            }
        } else if (ctx.FOR() != null) {
            BlockScopeTest scope = (BlockScopeTest) at.node2Scope.get(ctx); // 获得 Scope
            StackFrameTest frame = new StackFrameTest(scope); // 创建一个栈帧
            pushStack(frame); // 加入栈中

            ForControlContext forControl = ctx.forControl();
            if (forControl.enhancedForControl() != null) {

            } else {
                // 初始化部分执行一次
                if (forControl.forInit() != null) {
                    rtn = visitForInit(forControl.forInit());
                }
                while (true) {
                    Boolean condition = true; // 如果没有条件判断部分, 意味着一直循环
                    if (forControl.expression() != null) {
                        Object value = visitExpression(forControl.expression());
                        if (value instanceof LValueTest) {
                            condition = (Boolean) ((LValueTest) value).getValue();
                        } else {
                            condition = (Boolean) value;
                        }
                    }
                    if (condition) {
                        // 执行for的语句体
                        rtn = visitStatement(ctx.statement(0));
                        if (rtn instanceof BreakObjectTest) {
                            rtn = null;
                            break;
                        } else if (rtn instanceof ReturnObjectTest) {
                            break;
                        }
                        // 执行forUpdate, 通常是"i++"这样的语句, 这个执行顺序不能出错
                        if (forControl.forUpdate != null) {
                            visitExpressionList(forControl.forUpdate);
                        }
                    } else {
                        break;
                    }
                }
            }
            // 运行完毕, 弹出栈
            popStack();
        } else if (ctx.blockLabel != null) {
            rtn = visitBlock(ctx.blockLabel);
        } else if (ctx.BREAK() != null) {
            rtn = BreakObject.instance();
        } else if (ctx.RETURN() != null) {
            if (ctx.expression() != null) {
                rtn = visitExpression(ctx.expression());
                if (rtn instanceof LValueTest) {
                    rtn = ((LValueTest) rtn).getValue();
                }
                if (rtn instanceof FunctionObjectTest) {
                    FunctionObjectTest functionObject = (FunctionObjectTest) rtn;
                    getClosureValues(functionObject.function, functionObject);
                } else if (rtn instanceof ClassObjectTest) {
                    ClassObjectTest classObject = (ClassObjectTest) rtn;
                    getClosureValues(classObject);
                }

            }
            rtn = new ReturnObjectTest(rtn);
        }
        return rtn;
    }

    @Override
    public Object visitTypeType(TypeTypeContext ctx) {
        return visitPrimitiveType(ctx.primitiveType());
    }

    @Override
    public Object visitVariableDeclarator(VariableDeclaratorContext ctx) {
        Object rtn = null;
        LValueTest lValue = (LValueTest) visitVariableDeclaratorId(ctx.variableDeclaratorId());
        if (ctx.variableInitializer() != null) {
            rtn = visitVariableInitializer(ctx.variableInitializer());
            if (rtn instanceof LValueTest) {
                rtn = ((LValueTest) rtn).getValue();
            }
            lValue.setValue(rtn);
        }
        return rtn;
    }

    @Override
    public Object visitVariableDeclaratorId(VariableDeclaratorIdContext ctx) {
        Object rtn = null;
        SymbolTest symbol = at.symbolOfNode.get(ctx);
        rtn = getLValue((VariableTest) symbol);
        return rtn;
    }

    @Override
    public Object visitVariableDeclarators(VariableDeclaratorsContext ctx) {
        Object rtn = null;
        for (VariableDeclaratorContext child : ctx.variableDeclarator()) {
            rtn = visitVariableDeclarator(child);
        }
        return rtn;
    }

    @Override
    public Object visitVariableInitializer(VariableInitializerContext ctx) {
        Object rtn = null;
        if (ctx.expression() != null) {
            rtn = visitExpression(ctx.expression());
        }
        return rtn;
    }

    @Override
    public Object visitProg(ProgContext ctx) {
        Object rtn = null;
        pushStack(new StackFrameTest((BlockScopeTest) at.node2Scope.get(ctx)));
        rtn = visitBlockStatements(ctx.blockStatements());
        popStack();
        return rtn;
    }

    @Override
    public Object visitFunctionCall(FunctionCallContext ctx) {
        if (ctx.THIS() != null) {
            thisConstructor(ctx);
            return null;
        } else if (ctx.SUPER() != null) {
            thisConstructor(ctx);
            return null;
        }
        Object rtn = null;
        String functionName = ctx.IDENTIFIER().getText();
        SymbolTest symbol = at.symbolOfNode.get(ctx);
        if (symbol instanceof DefaultConstructorTest) {
            return createAndInitClassObject(((DefaultConstructorTest) symbol).Class());
        } else if (functionName.equals("println")) {
            println(ctx);
            return rtn;
        }

        FunctionObjectTest functionObject = getFunctionObject(ctx);
        FunctionTest function = functionObject.function;

        if (function.isConstructor()) {
            ClassTest theClass = (ClassTest) function.enclosingScope;
            ClassObjectTest newObject = createAndInitClassObject(theClass);
            methodCall(newObject, ctx, false);
            return newObject;
        }

        //计算参数值
        List<Object> paramValues = calcParamValues(ctx);

        if (traceFunctionCall) {
            System.out.println("\n>>FunctionCall : " + ctx.getText());
        }

        rtn = functionCall(functionObject, paramValues);

        return rtn;
    }

    private List<Object> calcParamValues(FunctionCallContext ctx) {
        List<Object> paramValues = new LinkedList<Object>();
        if (ctx.expressionList() != null) {
            for (ExpressionContext exp : ctx.expressionList().expression()) {
                Object value = visitExpression(exp);
                if (value instanceof LValueTest) {
                    value = ((LValueTest) value).getValue();
                }
                paramValues.add(value);
            }
        }
        return paramValues;
    }

    private FunctionObjectTest getFunctionObject(FunctionCallContext ctx) {
        if (ctx.IDENTIFIER() == null) return null;

        FunctionTest function = null;
        FunctionObjectTest functionObject = null;

        SymbolTest symbol = at.symbolOfNode.get(ctx);
        if (symbol instanceof VariableTest) {
            VariableTest variable = (VariableTest) symbol;
            LValueTest lValue = getLValue(variable);
            Object value = lValue.getValue();
            if (value instanceof FunctionObjectTest) {
                functionObject = (FunctionObjectTest) value;
                function = functionObject.function;
            }
        } else if (symbol instanceof FunctionTest) {
            function = (FunctionTest) symbol;
        } else {
            String functionName = ctx.IDENTIFIER().getText();
            at.log("unable to find function or function variable " + functionName, ctx);
            return null;
        }

        if (functionObject == null) {
            functionObject = new FunctionObjectTest(function);
        }

        return functionObject;
    }

    private Object functionCall(FunctionObjectTest functionObject, List<Object> paramValues) {
        Object rtn = null;
        StackFrameTest functionFrame = new StackFrameTest(functionObject);
        pushStack(functionFrame);

        FunctionDeclarationContext functionCode = (FunctionDeclarationContext) functionObject.function.ctx;
        if (functionCode.formalParameters().formalParameterList() != null) {
            for (int i = 0; i < functionCode.formalParameters().formalParameterList().formalParameter().size(); i++) {
                FormalParameterContext param = functionCode.formalParameters().formalParameterList().formalParameter(i);
                LValueTest lValue = (LValueTest) visitVariableDeclaratorId(param.variableDeclaratorId());
                lValue.setValue(paramValues.get(i));
            }
        }
        rtn = visitFunctionDeclaration(functionCode);
        popStack();
        if (rtn instanceof ReturnObject) {
            rtn = ((ReturnObject) rtn).returnValue;
        }
        return rtn;
    }

    private Object methodCall(ClassObjectTest classObject, FunctionCallContext ctx, boolean isSuper) {
        Object rtn = null;

        StackFrameTest classFrame = new StackFrameTest(classObject);
        pushStack(classFrame);
        FunctionObjectTest funtionObject = getFunctionObject(ctx);
        popStack();

        FunctionTest function = funtionObject.function;

        ClassTest theClass = classObject.type;
        if (!function.isConstructor() && !isSuper) {
            FunctionTest overrided = theClass.getFunction(function.name, function.getParamTypes());
            if (overrided != null && overrided != function) {
                function = overrided;
                funtionObject.setFunction(function);
            }
        }
        List<Object> paramValues = calcParamValues(ctx);

        pushStack(classFrame);
        rtn = functionCall(funtionObject, paramValues);
        popStack();

        return rtn;
    }

    private void thisConstructor(FunctionCallContext ctx) {
        SymbolTest symbol = at.symbolOfNode.get(ctx);
        if (symbol instanceof DefaultConstructorTest) {
            return;
        } else if (symbol instanceof FunctionTest) {
            FunctionTest function = (FunctionTest) symbol;
            FunctionObjectTest functionObject = new FunctionObjectTest(function);
            List<Object> paramValues = calcParamValues(ctx);
            functionCall(functionObject, paramValues);
        }
    }

    @Override
    public Object visitFunctionDeclaration(FunctionDeclarationContext ctx) {
        return visitFunctionBody(ctx.functionBody());
    }

    @Override
    public Object visitFunctionBody(FunctionBodyContext ctx) {
        Object rtn = null;
        if (ctx.block() != null) {
            rtn = visitBlock(ctx.block());
        }
        return rtn;
    }

    @Override
    public Object visitClassBody(ClassBodyContext ctx) {
        Object rtn = null;
        for (ClassBodyDeclarationContext child : ctx.classBodyDeclaration()) {
            rtn = visitClassBodyDeclaration(child);
        }
        return rtn;
    }

    @Override
    public Object visitClassBodyDeclaration(ClassBodyDeclarationContext ctx) {
        Object rtn = null;
        if (ctx.memberDeclaration() != null) {
            rtn = visitMemberDeclaration(ctx.memberDeclaration());
        }
        return rtn;
    }


    @Override
    public Object visitMemberDeclaration(MemberDeclarationContext ctx) {
        Object rtn = null;
        if (ctx.fieldDeclaration() != null) {
            rtn = visitFieldDeclaration(ctx.fieldDeclaration());
        }
        return rtn;
    }

    @Override
    public Object visitFieldDeclaration(FieldDeclarationContext ctx) {
        Object rtn = null;
        if (ctx.variableDeclarators() != null) {
            rtn = visitVariableDeclarators(ctx.variableDeclarators());
        }
        return rtn;
    }
}