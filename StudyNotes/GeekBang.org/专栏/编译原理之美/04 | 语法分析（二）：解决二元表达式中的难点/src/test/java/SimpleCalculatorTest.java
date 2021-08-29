import org.junit.Test;

public class SimpleCalculatorTest {

    @Test
    public void test1() {
        SimpleCalculatorTest calculator = new SimpleCalculatorTest();
        String script = "2 + 3 * 5";
        System.out.println("解析变量声明语句: " + script);
        calculator.evaluate(script);
    }

    @Test
    public void test2() {
        SimpleCalculatorTest calculator = new SimpleCalculatorTest();
        String script = "int age = 45";
        System.out.println("解析变量声明语句: " + script);
        calculator.evaluate(script);
    }

    @Test
    public void test3() {
        SimpleCalculatorTest calculator = new SimpleCalculatorTest();
        String script = "2 + 3 + 4";
        System.out.println("解析变量声明语句: " + script);
        calculator.evaluate(script);
    }

    private void evaluate(String script) {
        try {
            ASTNode tree = parse(script);
            System.out.println("================dumpAST=================");
            dumpAST(tree, "");
            System.out.println("================evaluate================");
            evaluate(tree, "");
            System.out.println("========================================");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private int evaluate(ASTNode node, String indent) {
        int result = 0;
        System.out.println(indent + "Calculating: " + node.getType());
        switch (node.getType()) {
            case Programm:
            case IntDeclaration:
            case AssignmentStmt:
                for (ASTNode child : node.getChildren()) {
                    result = evaluate(child, indent + "\t");
                }
                break;
            case Additive:
                ASTNode child1 = node.getChildren().get(0);
                int value1 = evaluate(child1, indent + "\t");
                ASTNode child2 = node.getChildren().get(1);
                int value2 = evaluate(child2, indent + "\t");
                if (node.getText().equals("+")) {
                    result = value1 + value2;
                } else {
                    result = value1 - value2;
                }
                break;
            case Multiplicative:
                child1 = node.getChildren().get(0);
                value1 = evaluate(child1, indent + "\t");
                child2 = node.getChildren().get(1);
                value2 = evaluate(child2, indent + "\t");
                if (node.getText().equals("*")) {
                    result = value1 * value2;
                } else {
                    result = value1 / value2;
                }
                break;
            case IntLiteral:
                result = Integer.valueOf(node.getText()).intValue();
                break;
            default:
        }
        System.out.println(indent + "Result: " + result);
        return result;
    }

    private ASTNode parse(String script) throws Exception {
        SimpleLexer lexer = new SimpleLexer();
        TokenReader tokens = lexer.tokenize(script);
        ASTNode rootNode = prog(tokens);
        return rootNode;
    }

    private ASTNode prog(TokenReader tokens) throws Exception {
        SimpleASTNode node = new SimpleASTNode(ASTNodeType.Programm, "Calculator");

        SimpleASTNode child = intDeclare(tokens);
        if (child != null) {
            node.addChild(child);
        }
        return node;
    }

    private void dumpAST(ASTNode node, String indent) {
        System.out.println(indent + node.getType() + " " + node.getText());
        for (ASTNode child : node.getChildren()) {
            dumpAST(child, indent + "\t");
        }
    }

    private SimpleASTNode intDeclare(TokenReader tokens) throws Exception {
        SimpleASTNode node;
        Token token = tokens.peek();
        if (token != null && token.getType() == TokenType.Int) {
            tokens.read();
            if (tokens.peek().getType() == TokenType.Identifier) {
                token = tokens.read();
                node = new SimpleASTNode(ASTNodeType.IntDeclaration, token.getText());
                token = tokens.peek();
                if (token != null && token.getType() == TokenType.Assignment) {
                    tokens.read();
                    SimpleASTNode child = additive(tokens);

                    if (child == null) {
                        throw new Exception("invalide variable initialization, expecting an expression");
                    } else {
                        SimpleASTNode assignment  = new SimpleASTNode(ASTNodeType.AssignmentStmt, token.getText());
                        node.addChild(assignment);
                        assignment.addChild(child);
                    }
                }
            } else {
                throw new Exception("variable name expected");
            }
        } else {
            node = additive(tokens);
        }
        return node;
    }

    private SimpleASTNode additive(TokenReader tokens) throws Exception {
        SimpleASTNode child1 = multiplicative(tokens);
        SimpleASTNode node = child1;

        Token token = tokens.peek();
        if (child1 != null && token != null) {
            if (token.getType() == TokenType.Plus || token.getType() == TokenType.Minus) {
                token = tokens.read();
                SimpleASTNode child2 = additive(tokens);
                if (child2 != null) {
                    node = new SimpleASTNode(ASTNodeType.Additive, token.getText());
                    node.addChild(child1);
                    node.addChild(child2);
                } else {
                    throw new Exception("invalid additive expression, expecting the right part.");
                }
            }
        }
        return node;
    }

    private SimpleASTNode multiplicative(TokenReader tokens) throws Exception {
        SimpleASTNode child1 = primary(tokens);
        SimpleASTNode node = child1;

        Token token = tokens.peek();
        if (child1 != null && token != null) {
            if (token.getType() == TokenType.Star || token.getType() == TokenType.Slash) {
                token = tokens.read();
                SimpleASTNode child2 = multiplicative(tokens);
                if (child2 != null) {
                    node = new SimpleASTNode(ASTNodeType.Multiplicative, token.getText());
                    node.addChild(child1);
                    node.addChild(child2);
                } else {
                    throw new Exception("invalid multiplicative expression, expecting the right part.");
                }
            }
        }

        return node;
    }

    private SimpleASTNode primary(TokenReader tokens) {
        SimpleASTNode node = null;
        Token token = tokens.peek();
        if (token != null) {
            if (token.getType() == TokenType.IntLiteral) {
                token = tokens.read();
                node = new SimpleASTNode(ASTNodeType.IntLiteral, token.getText());
            } else if (token.getType() == TokenType.Identifier) {
                token = tokens.read();
                node = new SimpleASTNode(ASTNodeType.Identifier, token.getText());
            }
        }
        return node;
    }
}
