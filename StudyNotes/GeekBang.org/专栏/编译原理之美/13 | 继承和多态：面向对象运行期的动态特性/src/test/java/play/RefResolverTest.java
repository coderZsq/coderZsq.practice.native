package play;

import org.antlr.v4.runtime.tree.ParseTreeWalker;
import play.PlayScriptParser.*;

import java.util.LinkedList;
import java.util.List;

public class RefResolverTest extends PlayScriptBaseListener {

    ParseTreeWalker typeResolverEalker = new ParseTreeWalker();
    TypeResolverTest localVariableEnter = null;
    private AnnotatedTreeTest at;
    private List<FunctionCallContext> thisConstructorList = new LinkedList<>();
    private List<FunctionCallContext> superConstructorList = new LinkedList<>();

    public RefResolverTest(AnnotatedTreeTest at) {
        this.at = at;
        localVariableEnter = new TypeResolverTest(at, true);
    }

    @Override
    public void enterVariableDeclarators(VariableDeclaratorsContext ctx) {
        ScopeTest scope = at.enclosingScopeOfNode(ctx);
        if (scope instanceof BlockScopeTest || scope instanceof FunctionTest) {
            typeResolverEalker.walk(localVariableEnter, ctx);
        }
    }

    @Override
    public void exitPrimary(PrimaryContext ctx) {
        ScopeTest scope = at.enclosingScopeOfNode(ctx);
        TypeTest type = null;
        if (ctx.IDENTIFIER() != null) {
            String idName = ctx.IDENTIFIER().getText();
            VariableTest variable = at.lookupVariable(scope, idName);
            if (variable == null) {
                FunctionTest function = at.lookupFunction(scope, idName);
                if (function != null) {
                    at.symbolOfNode.put(ctx, function);
                    type = function;
                } else {
                    at.log("unknown variable or function: " + idName, ctx);
                }
            } else {
                at.symbolOfNode.put(ctx, variable);
                type = variable.type;
            }
        } else if (ctx.literal() != null) {
            type = at.typeOfNode.get(ctx.literal());
        } else if (ctx.expression() != null) {
            type = at.typeOfNode.get(ctx.expression());
        } else if (ctx.THIS() != null) {
            ClassTest theClass = at.enclosingClassOfNode(ctx);
            if (theClass != null) {
                ThisTest variable = theClass.getThis();
                at.symbolOfNode.put(ctx, variable);
                type = theClass;
            } else {
                at.log("keyword \"this\" can only be used inside a class", ctx);
            }
        } else if (ctx.SUPER() != null) {
            ClassTest theClass = at.enclosingClassOfNode(ctx);
            if (theClass != null) {
                SuperTest variable = theClass.getSuper();
                at.symbolOfNode.put(ctx, variable);
                type = theClass;
            } else {
                at.log("keyword \"super\" can only be used inside a class", ctx);
            }
        }
        at.typeOfNode.put(ctx, type);
    }

    @Override
    public void exitFunctionCall(FunctionCallContext ctx) {

        if (ctx.THIS() != null) {
            thisConstructorList.add(ctx);
            return;
        } else if (ctx.SUPER() != null) {
            superConstructorList.add(ctx);
            return;
        }

        if (ctx.IDENTIFIER().getText().equals("println")) {
            return;
        }

        String idName = ctx.IDENTIFIER().getText();
        List<TypeTest> paramTypes = getParamTypes(ctx);

        boolean found = false;

        if (ctx.parent instanceof ExpressionContext) {
            ExpressionContext exp = (ExpressionContext) ctx.parent;
            if (exp.bop != null && exp.bop.getType() == PlayScriptParser.DOT) {
                SymbolTest symbol = at.symbolOfNode.get(exp.expression(0));
                if (symbol instanceof VariableTest && ((VariableTest) symbol).type instanceof ClassTest) {
                    ClassTest theClass = (ClassTest) ((VariableTest) symbol).type;
                    FunctionTest function = theClass.getFunction(idName, paramTypes);
                    if (function != null) {
                        found = true;
                        at.symbolOfNode.put(ctx, function);
                        at.typeOfNode.put(ctx, function.getReturnType());
                    } else {
                        VariableTest funcVar = theClass.getFunctionVariable(idName, paramTypes);
                        if (funcVar != null) {
                            found = true;
                            at.symbolOfNode.put(ctx, function);
                            at.typeOfNode.put(ctx, ((FunctionTypeTest) funcVar.type).getReturnType());
                        } else {
                            at.log("unable to find method " + idName + " in Class " + theClass.name, exp);
                        }
                    }
                } else {
                    at.log("unable to resolve a class", ctx);
                }
            }
        }

        ScopeTest scope = at.enclosingScopeOfNode(ctx);

        if (!found) {
            FunctionTest function = at.lookupFunction(scope, idName, paramTypes);
            if (function != null) {
                found = true;
                at.symbolOfNode.put(ctx, function);
                at.typeOfNode.put(ctx, function.returnType);
            }
        }

        if (!found) {
            // 看看是不是类的构建函数, 用相同的名称查找一个 class
            ClassTest theClass = at.lookupClass(scope, idName);
            if (theClass != null) {
                FunctionTest function = theClass.findConstructor(paramTypes);
                if (function != null) {
                    found = true;
                    at.symbolOfNode.put(ctx, function);
                }
                // 如果是与类名相同的方法, 并且没有参数, 那么就是缺省构造方法
                else if (ctx.expressionList() == null) {
                    found = true;
                    // at.symbolOfNode.put(ctx, theClass); // TODO 直接赋予 class
                    at.symbolOfNode.put(ctx, theClass.defaultConstructor());
                } else {
                    at.log("unkown class constructor: " + ctx.getText(), ctx);
                }
                at.typeOfNode.put(ctx, theClass);
            } else {
                VariableTest variable = at.lookupFunctionVariable(scope, idName, paramTypes);
                if (variable != null && variable.type instanceof FunctionTypeTest) {
                    found = true;
                    at.symbolOfNode.put(ctx, variable);
                    at.typeOfNode.put(ctx, variable.type);
                } else {
                    at.log("unknown function or function variable: " + ctx.getText(), ctx);
                }
            }
        }
    }

    private void resolveThisConstructorCall(FunctionCallContext ctx) {
        ClassTest theClass = at.enclosingClassOfNode(ctx);
        if (theClass != null) {
            FunctionTest function = at.enclosingFunctionOfNode(ctx);
            if (function != null && function.isConstructor()) {
                FunctionDeclarationContext fdx = (FunctionDeclarationContext) function.ctx;
                if (!firstStatementInFunction(fdx, ctx)) {
                    at.log("this() must be first statement in a constructor", ctx);
                    return;
                }
                List<TypeTest> paramTypes = getParamTypes(ctx);
                FunctionTest referd = theClass.findConstructor(paramTypes);
                if (referd != null) {
                    at.symbolOfNode.put(ctx, referd);
                    at.typeOfNode.put(ctx, theClass);
                    at.thisConstructorRef.put(function, referd);
                } else if (paramTypes.size() == 0) {
                    at.symbolOfNode.put(ctx, theClass.defaultConstructor());
                } else {
                    at.log("can not find a constructor matches this()", ctx);
                }
            } else {
                at.log("this() should only be called inside a class constructor", ctx);
            }
        } else {
            at.log("this() should only be called inside a class", ctx);
        }
    }

    private boolean firstStatementInFunction(FunctionDeclarationContext fdx, FunctionCallContext ctx) {
        if (fdx.functionBody().block().blockStatements().blockStatement(0).statement() != null
                && fdx.functionBody().block().blockStatements().blockStatement(0).statement().expression() != null
                && fdx.functionBody().block().blockStatements().blockStatement(0).statement().expression().functionCall() == ctx) {
            return true;
        }
        return false;
    }

    private void resolveSuperConstructorCall(FunctionCallContext ctx) {
        ClassTest theClass = at.enclosingClassOfNode(ctx);
        if (theClass != null) {
            FunctionTest function = at.enclosingFunctionOfNode(ctx);
            if (function != null && function.isConstructor()) {
                ClassTest parentClass = theClass.getParentClass();
                if (parentClass != null) {
                    //检查是不是构造函数中的第一句
                    FunctionDeclarationContext fdx = (FunctionDeclarationContext) function.ctx;
                    if (!firstStatementInFunction(fdx, ctx)) {
                        at.log("super() must be first statement in a constructor", ctx);
                        return;
                    }

                    List<TypeTest> paramTypes = getParamTypes(ctx);
                    FunctionTest refered = parentClass.findConstructor(paramTypes);
                    if (refered != null) {
                        at.symbolOfNode.put(ctx, refered);
                        at.typeOfNode.put(ctx, theClass);
                        at.superConstructorRef.put(function, refered);

                    } else if (paramTypes.size() == 0) {
                        at.symbolOfNode.put(ctx, parentClass.defaultConstructor());
                        at.typeOfNode.put(ctx, theClass);
                        at.superConstructorRef.put(function, theClass.defaultConstructor());
                    } else {
                        at.log("can not find a constructor matches this()", ctx);
                    }
                } else {
                }
            } else {
                at.log("super() should only be called inside a class constructor", ctx);
            }
        } else {
            at.log("super() should only be called inside a class", ctx);
        }
    }

    private List<TypeTest> getParamTypes(PlayScriptParser.FunctionCallContext ctx) {
        List<TypeTest> paramTypes = new LinkedList<>();
        if (ctx.expressionList() != null) {
            for (ExpressionContext exp : ctx.expressionList().expression()) {
                TypeTest type = at.typeOfNode.get(exp);
                paramTypes.add(type);
            }
        }
        return paramTypes;
    }

    @Override
    public void exitExpression(ExpressionContext ctx) {
        TypeTest type = null;

        if (ctx.bop != null && ctx.bop.getType() == PlayScriptParser.DOT) {
            SymbolTest symbol = at.symbolOfNode.get(ctx.expression(0));
            if (symbol instanceof VariableTest && ((VariableTest) symbol).type instanceof ClassTest) {
                ClassTest theClass = (ClassTest) ((VariableTest) symbol).type;
                if (ctx.IDENTIFIER() != null) {
                    String idName = ctx.IDENTIFIER().getText();
                    VariableTest variable = at.lookupVariable(theClass, idName);
                    if (variable != null) {
                        at.symbolOfNode.put(ctx, variable);
                        type = variable.type;
                    } else {
                        at.log("unable to find field " + idName + " in Class " + theClass.name, ctx);
                    }
                } else if (ctx.functionCall() != null) {
                    type = at.typeOfNode.get(ctx.functionCall());
                }
            } else {
                at.log("symbol is not a qualified object：" + symbol, ctx);
            }
        } else {
            SymbolTest symbol = at.symbolOfNode.get(ctx.primary());
            at.symbolOfNode.put(ctx, symbol);
        }

        if (ctx.primary() != null) {
            type = at.typeOfNode.get(ctx.primary());
        } else if (ctx.functionCall() != null) {
            type = at.typeOfNode.get(ctx.functionCall());
        } else if (ctx.bop != null && ctx.expression().size() >= 2) {
            TypeTest type1 = at.typeOfNode.get(ctx.expression(0));
            TypeTest type2 = at.typeOfNode.get(ctx.expression(1));

            switch (ctx.bop.getType()) {
                case PlayScriptParser.ADD:
                    if (type1 == PrimitiveTypeTest.String || type2 == PrimitiveTypeTest.String) {
                        type = PrimitiveTypeTest.String;
                    } else if (type1 instanceof PrimitiveTypeTest && type2 instanceof PrimitiveTypeTest) {
                        // 类型"向上"对齐, 比如一个 int 一个 float, 取 float
                        type = PrimitiveTypeTest.getUpperType(type1, type2);
                    } else {
                        at.log("operand should be PrimitiveType for additive and multiplicative operation", ctx);
                    }
                case PlayScriptParser.SUB:
                case PlayScriptParser.MUL:
                case PlayScriptParser.DIV:
                    if (type1 instanceof PrimitiveTypeTest && type2 instanceof PrimitiveTypeTest) {
                        type = PrimitiveTypeTest.getUpperType(type1, type2);
                    } else {
                        at.log("operand should be PrimitiveType for additive and multiplicative operation", ctx);
                    }

                    break;
                case PlayScriptParser.EQUAL:
                case PlayScriptParser.NOTEQUAL:
                case PlayScriptParser.LE:
                case PlayScriptParser.LT:
                case PlayScriptParser.GE:
                case PlayScriptParser.GT:
                case PlayScriptParser.AND:
                case PlayScriptParser.OR:
                case PlayScriptParser.BANG:
                    type = PrimitiveTypeTest.Boolean;
                    break;
                case PlayScriptParser.ASSIGN:
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
                    type = type1;
                    break;
            }
        }
        at.typeOfNode.put(ctx, type);
    }

    @Override
    public void exitVariableInitializer(VariableInitializerContext ctx) {
        if (ctx.expression() != null) {
            at.typeOfNode.put(ctx, at.typeOfNode.get(ctx.expression()));
        }
    }

    @Override
    public void exitLiteral(LiteralContext ctx) {
        if (ctx.BOOL_LITERAL() != null) {
            at.typeOfNode.put(ctx, PrimitiveTypeTest.Boolean);
        } else if (ctx.CHAR_LITERAL() != null) {
            at.typeOfNode.put(ctx, PrimitiveTypeTest.Char);
        } else if (ctx.NULL_LITERAL() != null) {
            at.typeOfNode.put(ctx, PrimitiveTypeTest.Null);
        } else if (ctx.STRING_LITERAL() != null) {
            at.typeOfNode.put(ctx, PrimitiveTypeTest.String);
        } else if (ctx.integerLiteral() != null) {
            at.typeOfNode.put(ctx, PrimitiveTypeTest.Integer);
        } else if (ctx.floatLiteral() != null) {
            at.typeOfNode.put(ctx, PrimitiveTypeTest.Float);
        }
    }

    @Override
    public void exitProg(ProgContext ctx) {
        for (FunctionCallContext fcc : thisConstructorList){
            resolveThisConstructorCall(fcc);
        }
        for (FunctionCallContext fcc : superConstructorList){
            resolveSuperConstructorCall(fcc);
        }
    }
}
