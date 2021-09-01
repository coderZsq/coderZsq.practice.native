package play;

public class StackFrameTest {
    // 该 frame 所对应的 scope
    ScopeTest scope = null;

    // enclosingScope 所对应的 frame
    StackFrameTest parentFrame = null;

    // 实际存放变量的地方
    PlayObjectTest object = null;

    protected boolean contains(VariableTest variable) {
        if (object != null && object.fields != null) {
            return object.fields.containsKey(variable);
        }
        return false;
    }

    public StackFrameTest(ScopeTest scope) {
        this.scope = scope;
        this.object = new PlayObjectTest();
    }

    public StackFrameTest(ClassObjectTest object) {
        this.scope = object.type;
        this.object = object;
    }

    public StackFrameTest(FunctionObjectTest object) {
        this.scope = object.function;
        this.object = object;
    }

    @Override
    public String toString() {
        String rtn = "" + scope;
        if (parentFrame != null) {
            rtn += " -> " + parentFrame;
        }
        return rtn;
    }
}
