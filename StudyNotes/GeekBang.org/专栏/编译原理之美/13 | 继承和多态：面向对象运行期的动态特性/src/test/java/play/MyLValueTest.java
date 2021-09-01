package play;

public class MyLValueTest implements LValueTest {
    private VariableTest variable;
    private PlayObjectTest valueContainer;

    public MyLValueTest(PlayObjectTest valueContainer, VariableTest variable) {
        this.valueContainer = valueContainer;
        this.variable = variable;
    }

    @Override
    public Object getValue() {
        if (variable instanceof ThisTest || variable instanceof SuperTest) {
            return valueContainer;
        }
        return valueContainer.getValue(variable);
    }

    @Override
    public void setValue(Object value) {
        valueContainer.setValue(variable, value);

        if (value instanceof FunctionObjectTest) {
            ((FunctionObjectTest) value).receiver = variable;
        }
    }

    @Override
    public VariableTest getVariable() {
        return variable;
    }

    @Override
    public String toString() {
        return "LValue of " + variable.name + " : " + getValue();
    }

    @Override
    public PlayObjectTest getValueContainer() {
        return valueContainer;
    }
}
