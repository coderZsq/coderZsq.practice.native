package play;

import java.util.LinkedList;
import java.util.List;

import play.PlayScriptParser.*;

public class RefResolverTest extends PlayScriptBaseListener {
    AnnotatedTreeTest at;

    @Override
    public void exitFunctionCall(PlayScriptParser.FunctionCallContext ctx) {
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
            }
            else {
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
}
