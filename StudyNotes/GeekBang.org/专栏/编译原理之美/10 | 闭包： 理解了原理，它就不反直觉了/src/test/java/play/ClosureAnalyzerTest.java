package play;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.RuleContext;

import java.util.HashSet;
import java.util.Set;

public class ClosureAnalyzerTest {
    AnnotatedTreeTest at = null;

    public ClosureAnalyzerTest(AnnotatedTreeTest at) {
        this.at = at;
    }

    public void analyzeClosures() {
        for (TypeTest type : at.types) {
            if (type instanceof FunctionTest && !((FunctionTest) type).isMethod()) {
                Set set = calcClosureVariables((FunctionTest) type);
                if (set.size() > 0) {
                    ((FunctionTest)type).closureVariables = set;
                }
            }
        }
    }

    /**
     * 为某个函数计算闭包变量，也就是它所引用的外部环境变量。
     * 算法：计算所有的变量引用，去掉内部声明的变量，剩下的就是外部的。
     * @param function
     * @return
     */
    private Set<VariableTest> calcClosureVariables(FunctionTest function) {
        Set<VariableTest> refered = variablesReferedByScope(function);
        Set<VariableTest> declared = variablesDeclaredUnderScope(function);
        refered.removeAll(declared);
        return refered;
    }

    private Set<VariableTest> variablesReferedByScope(ScopeTest scope) {
        Set<VariableTest> rtn = new HashSet<>();
        ParserRuleContext scopeNode = scope.ctx;
        for (ParserRuleContext node : at.symbolOfNode.keySet()) {
            SymbolTest symbol = at.symbolOfNode.get(node);
            if (symbol instanceof VariableTest && isAncestor(scopeNode, node)) {
                rtn.add((VariableTest) symbol);
            }
        }
        return rtn;
    }

    private boolean isAncestor(RuleContext node1, RuleContext node2) {
        if (node2.parent == null) {
            return false;
        }
        else if (node2.parent == node1) {
            return true;
        }
        else {
            return isAncestor(node1, node2.parent);
        }
    }

    private Set<VariableTest> variablesDeclaredUnderScope(ScopeTest scope) {
        Set<VariableTest> rtn = new HashSet<>();
        for (SymbolTest symbol : scope.symbols) {
            if (symbol instanceof VariableTest) {
                rtn.add((VariableTest) symbol);
            }
            else if (symbol instanceof ScopeTest) {
                rtn.addAll(variablesDeclaredUnderScope((ScopeTest) symbol));
            }
        }
        return rtn;
    }

}
