package play;

public class StackFrameTest {
    // 该 frame 所对应的 scope
    ScopeTest scope = null;

    // enclosingScope 所对应的 frame
    StackFrameTest parentFrame = null;

    // 实际存放变量的地方
    PlayObjectTest object = null;

    public StackFrameTest(ScopeTest scope) {
        this.scope = scope;
    }

    public StackFrameTest(FunctionObjectTest functionObject) {

    }

    public StackFrameTest(ClassObjectTest obj) {

    }
}
