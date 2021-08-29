package play;

import java.util.HashMap;
import java.util.Map;

public class PlayObjectTest {
    // 成员变量
    protected Map<VariableTest, Object> fields = new HashMap<VariableTest, Object>();

    public Object getValue(VariableTest variable) {
        Object rtn = fields.get(variable);
        return rtn;
    }

    public void setValue(VariableTest variable, Object value) {
        fields.put(variable, value);
    }
}
