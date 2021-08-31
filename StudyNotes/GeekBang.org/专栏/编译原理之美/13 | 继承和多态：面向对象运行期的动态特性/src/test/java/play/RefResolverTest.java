package play;

import org.antlr.v4.runtime.tree.ParseTreeWalker;
import play.PlayScriptParser.*;

import java.util.LinkedList;
import java.util.List;

public class RefResolverTest extends PlayScriptBaseListener {

    private AnnotatedTreeTest at;
    ParseTreeWalker typeResolverEalker = new ParseTreeWalker();
    TypeResolverTest localVariableEnter = null;

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
    public void exitFunctionCall(FunctionCallContext ctx) {
        String idName = ctx.IDENTIFIER().getText();
        ScopeTest scope = at.enclosingScopeOfNode(ctx);
        FunctionTest function;
        List<TypeTest> paramTypes = getParamTypes(ctx);

        // 看看是不是类的构建函数, 用相同的名称查找一个 class
        ClassTest theClass = at.lookupClass(scope, idName);
        if (theClass != null) {
            function = theClass.findConstructor(paramTypes);
            if (function != null) {
                at.symbolOfNode.put(ctx, function);
            }
            // 如果是与类名相同的方法, 并且没有参数, 那么就是缺省构造方法
            else if (ctx.expressionList() == null) {
                at.symbolOfNode.put(ctx, theClass); // TODO 直接赋予 class
            } else {
                at.log("unkown class constructor: " + ctx.getText(), ctx);
            }
            at.typeOfNode.put(ctx, theClass);
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
            }
        }

        at.typeOfNode.put(ctx, type);
    }
}
