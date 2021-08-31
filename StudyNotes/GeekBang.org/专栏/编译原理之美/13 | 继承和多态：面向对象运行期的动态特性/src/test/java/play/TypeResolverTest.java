package play;

import play.PlayScriptParser.*;

public class TypeResolverTest extends PlayScriptBaseListener {

    private AnnotatedTreeTest at = null;
    private boolean enterLocalVariable = false;

    public TypeResolverTest(AnnotatedTreeTest at) {
        this.at = at;
    }

    public TypeResolverTest(AnnotatedTreeTest at, boolean enterLocalVariable) {
        this.at = at;
        this.enterLocalVariable = enterLocalVariable;
    }

    @Override
    public void exitVariableDeclarators(VariableDeclaratorsContext ctx) {
        ScopeTest scope = at.enclosingScopeOfNode(ctx);
        if (scope instanceof ClassTest || enterLocalVariable) {
            TypeTest type = at.typeOfNode.get(ctx.typeType());
            for (VariableDeclaratorContext child : ctx.variableDeclarator()) {
                VariableTest variable = (VariableTest) at.symbolOfNode.get(child.variableDeclaratorId());
                variable.type = type;
            }
        }
    }

    @Override
    public void enterVariableDeclaratorId(VariableDeclaratorIdContext ctx) {
        String idName = ctx.IDENTIFIER().getText();
        ScopeTest scope = at.enclosingScopeOfNode(ctx);
        if (scope instanceof ClassTest || enterLocalVariable || ctx.parent instanceof FormalParameterContext) {
            VariableTest variable = new VariableTest(idName, scope, ctx);
            if (ScopeTest.getVariable(scope, idName) != null) {
                at.log("Variable or parameter already Declared: " + idName, ctx);
            }
            scope.addSymbol(variable);
            at.symbolOfNode.put(ctx, variable);
        }
    }

    @Override
    public void exitFunctionDeclaration(FunctionDeclarationContext ctx) {
        FunctionTest function = (FunctionTest) at.node2Scope.get(ctx);
        if (ctx.typeTypeOrVoid() != null) {
            function.returnType = at.typeOfNode.get(ctx.typeTypeOrVoid());
        } else {

        }
        ScopeTest scope = at.enclosingScopeOfNode(ctx);
        FunctionTest found = ScopeTest.getFunction(scope, function.name, function.getParamTypes());
        if (found != null && found != found) {
            at.log("Function or method already Declared: " + ctx.getText(), ctx);
        }
    }

    @Override
    public void exitFormalParameter(FormalParameterContext ctx) {
        TypeTest type = at.typeOfNode.get(ctx.typeType());
        VariableTest variable = (VariableTest) at.symbolOfNode.get(ctx.variableDeclaratorId());
        variable.type = (TypeTest) type;
        ScopeTest scope = at.enclosingScopeOfNode(ctx);
        if (scope instanceof FunctionTest) {
            ((FunctionTest) scope).parameters.add(variable);
        }
    }

    @Override
    public void enterClassDeclaration(ClassDeclarationContext ctx) {
        ClassTest theClass = (ClassTest) at.node2Scope.get(ctx);
        if (ctx.EXTENDS() != null) {
            String parentClassName = ctx.typeType().getText();
            TypeTest type = at.lookupType(parentClassName);
            if (type != null && type instanceof ClassTest) {
                theClass.setParentClass((ClassTest) type);
            } else {
                at.log("unknown class: " + parentClassName, ctx);
            }
        }
    }

    @Override
    public void exitTypeTypeOrVoid(TypeTypeOrVoidContext ctx) {
        if (ctx.VOID() != null) {
            at.typeOfNode.put(ctx, VoidTypeTest.instance());
        } else if (ctx.typeType() != null) {
            at.typeOfNode.put(ctx, (TypeTest) at.typeOfNode.get(ctx.typeType()));
        }
    }

    @Override
    public void exitTypeType(TypeTypeContext ctx) {
        if (ctx.classOrInterfaceType() != null) {
            TypeTest type = at.typeOfNode.get(ctx.classOrInterfaceType());
            at.typeOfNode.put(ctx, type);
        } else if (ctx.functionType() != null) {
            TypeTest type = at.typeOfNode.get(ctx.functionType());
            at.typeOfNode.put(ctx, type);
        } else if (ctx.primitiveType() != null) {
            TypeTest type = at.typeOfNode.get((ctx.primitiveType()));
            at.typeOfNode.put(ctx, type);
        }
    }

    @Override
    public void enterClassOrInterfaceType(ClassOrInterfaceTypeContext ctx) {
        if (ctx.IDENTIFIER() != null) {
            ScopeTest scpoe = at.enclosingScopeOfNode(ctx);
            String idName = ctx.getText();
            ClassTest theClass = at.lookupClass(scpoe, idName);
            at.typeOfNode.put(ctx, theClass);
        }
    }

    @Override
    public void exitFunctionType(FunctionTypeContext ctx) {
        DefaultFunctionTypeTest functionType = new DefaultFunctionTypeTest();
        at.typeOfNode.put(ctx, functionType);

        at.typeOfNode.put(ctx, functionType);

        functionType.returnType = at.typeOfNode.get(ctx.typeTypeOrVoid());

        if (ctx.typeList() != null) {
            TypeListContext tcl = ctx.typeList();
            for (TypeTypeContext ttc : tcl.typeType()) {
                TypeTest type = at.typeOfNode.get(ttc);
                functionType.paramTypes.add(type);
            }
        }
    }

    @Override
    public void exitPrimitiveType(PrimitiveTypeContext ctx) {
        TypeTest type = null;
        if (ctx.BOOLEAN() != null) {
            type = PrimitiveTypeTest.Boolean;
        } else if (ctx.INT() != null) {
            type = PrimitiveTypeTest.Integer;
        } else if (ctx.LONG() != null) {
            type = PrimitiveTypeTest.Long;
        } else if (ctx.FLOAT() != null) {
            type = PrimitiveTypeTest.Float;
        } else if (ctx.DOUBLE() != null) {
            type = PrimitiveTypeTest.Double;
        } else if (ctx.BYTE() != null) {
            type = PrimitiveTypeTest.Byte;
        } else if (ctx.SHORT() != null) {
            type = PrimitiveTypeTest.Short;
        } else if (ctx.CHAR() != null) {
            type = PrimitiveTypeTest.Char;
        }else if (ctx.STRING() != null) {
            type = PrimitiveTypeTest.String;
        }

        at.typeOfNode.put(ctx, type);
    }
}
