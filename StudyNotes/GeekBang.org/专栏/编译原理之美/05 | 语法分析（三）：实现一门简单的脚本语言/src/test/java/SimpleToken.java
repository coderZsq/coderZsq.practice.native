public final class SimpleToken implements Token {
    public TokenType type = null;
    public String text = null;

    @Override
    public TokenType getType() {
        return type;
    }

    @Override
    public String getText() {
        return text;
    }

    @Override
    public String toString() {
        return "SimpleToken{" +
                "type=" + type +
                ", text='" + text + '\'' +
                '}';
    }
}
