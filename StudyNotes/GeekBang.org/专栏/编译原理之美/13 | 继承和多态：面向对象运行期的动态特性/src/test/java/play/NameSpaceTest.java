package play;

import org.antlr.v4.runtime.ParserRuleContext;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

public class NameSpaceTest extends BlockScopeTest {
    private NameSpaceTest parent = null;
    private List<NameSpaceTest> subNameSpaces = new LinkedList<>();
    private String name = null;

    public NameSpaceTest(String name, ScopeTest enclosingScope, ParserRuleContext ctx) {
        this.name = name;
        this.enclosingScope = enclosingScope;
        this.ctx = ctx;
    }

    public String getName() {
        return name;
    }

    public List<NameSpaceTest> subNameSpaces() {
        return Collections.unmodifiableList(subNameSpaces);
    }

    public void addSubNameScope(NameSpaceTest child) {
        child.parent = this;
        subNameSpaces.add(child);
    }

    public void removeSubNameSpace(NameSpaceTest child) {
        child.parent = null;
        subNameSpaces.remove(child);
    }
}
