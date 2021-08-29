import org.junit.Test;

import java.io.CharArrayReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class SimpleLexerTest {
    private StringBuffer tokenText = null;
    private List<Token> tokens = null;
    private SimpleToken token = null;

    @Test
    public void test1() {
        SimpleLexerTest lexer = new SimpleLexerTest();
        String script = "age >= 45";
        System.out.println("解析 : " + script);
        SimpleTokenReader tokenReader = lexer.tokenize(script);
        lexer.dump(tokenReader);
    }

    @Test
    public void test2() {
        SimpleLexerTest lexer = new SimpleLexerTest();
        String script = "intA = 10";
        System.out.println("解析 : " + script);
        SimpleTokenReader tokenReader = lexer.tokenize(script);
        lexer.dump(tokenReader);
    }

    @Test
    public void test3() {
        SimpleLexerTest lexer = new SimpleLexerTest();
        String script = "int age = 40";
        System.out.println("解析 : " + script);
        SimpleTokenReader tokenReader = lexer.tokenize(script);
        lexer.dump(tokenReader);
    }

    @Test
    public void test4() {
        SimpleLexerTest lexer = new SimpleLexerTest();
        String script = "2+3*5";
        System.out.println("解析 : " + script);
        SimpleTokenReader tokenReader = lexer.tokenize(script);
        lexer.dump(tokenReader);
    }

    private void dump(SimpleTokenReader tokenReader) {
        System.out.println("========================================");
        System.out.println("text\ttype");
        System.out.println();
        Token token;
        while ((token = tokenReader.read()) != null) {
            System.out.println(token.getText()+"\t\t"+token.getType());
        }
        System.out.println("========================================");
    }

    public SimpleTokenReader tokenize(String code) {
        tokens = new ArrayList<>();
        CharArrayReader reader = new CharArrayReader(code.toCharArray());
        tokenText = new StringBuffer();
        token = new SimpleToken();
        int ich = 0;
        char ch = 0;
        DfaState state = DfaState.Initial;
        try {
            while ((ich = reader.read()) != -1) {
                ch = (char) ich;
                System.out.println("========================================");
                System.out.println("遍历到的字符       : " + ch);
                System.out.println("解析前的状态       : " + state);
                System.out.println("当前解析前的 Token : " + token);

                switch (state) {
                    case Initial:
                        state = initToken(ch);
                        break;
                    case Id_int1:
                        if (ch == 'n') {
                            state = DfaState.Id_int2;
                            tokenText.append(ch);
                        }
                        break;
                    case Id_int2:
                        if (ch == 't') {
                            state = DfaState.Id_int3;
                            tokenText.append(ch);
                        }
                        break;
                    case Id_int3:
                        if (isBlank(ch)) {
                            token.type = TokenType.Int;
                            state = initToken(ch);
                        } else {
                            state = DfaState.Id;
                            tokenText.append(ch);
                        }
                        break;
                    case Id:
                        if (isAlpha(ch) || isDigit(ch)) {
                            tokenText.append(ch);
                        } else {
                            state = initToken(ch);
                        }
                        break;
                    case Assignment:
                    case Slash:
                    case GE:
                    case Plus:
                    case Star:
                        state = initToken(ch);
                        break;
                    case IntLiteral:
                        if (isDigit(ch)) {
                            tokenText.append(ch);
                        } else {
                            state = initToken(ch);
                        }
                        break;
                    case GT:
                        if (ch == '=') {
                            token.type = TokenType.GE;
                            state = DfaState.GE;
                            tokenText.append(ch);
                        } else {
                            state = initToken(ch);
                        }
                        break;
                        default:
                }
                System.out.println("当前解析后的 Token : " + token);
                System.out.println("临时保存文本 Token : " + tokenText);
                System.out.println("解析后的状态       : " + state);
            }
            if (tokenText.length() > 0) {
                initToken(ch);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return new SimpleTokenReader(tokens);
    }

    private boolean isBlank(char ch) {
        return ch == ' ' || ch == '\t' || ch == '\n';
    }

    private boolean isDigit(char ch) {
        return ch >= '0' && ch <= '9';
    }

    private DfaState initToken(char ch) {
        if (tokenText.length() > 0) {
            token.text = tokenText.toString();
            tokens.add(token);
            System.out.println("保存解析落盘 Tokens: " + tokens);
            tokenText = new StringBuffer();
            token = new SimpleToken();
        }

        DfaState newState;
        if (isAlpha(ch)) {
            if (ch == 'i') {
                newState = DfaState.Id_int1;
            } else {
                newState = DfaState.Id;
            }
            token.type = TokenType.Identifier;
            tokenText.append(ch);
        } else if (ch == '=') {
            newState = DfaState.Assignment;
            token.type = TokenType.Assignment;
            tokenText.append(ch);
        } else if (isDigit(ch)) {
          newState = DfaState.IntLiteral;
          token.type = TokenType.IntLiteral;
          tokenText.append(ch);
        } else if (ch == ';') {
            newState = DfaState.Slash;
            token.type = TokenType.Slash;
            tokenText.append(ch);
        } else if (ch == '>') {
            newState = DfaState.GT;
            token.type = TokenType.GT;
            tokenText.append(ch);
        } else if (ch == '+') {
            newState = DfaState.Plus;
            token.type = TokenType.Plus;
            tokenText.append(ch);
        } else if (ch == '*') {
            newState = DfaState.Star;
            token.type = TokenType.Star;
            tokenText.append(ch);
        }
        else {
            System.out.println("重置初始化的 Token : " + ch);
            newState = DfaState.Initial;
        }
        return newState;
    }

    private boolean isAlpha(char ch) {
        return ch >= 'a' && ch <= 'z' || ch >= 'A' && ch <= 'Z';
    }
}
