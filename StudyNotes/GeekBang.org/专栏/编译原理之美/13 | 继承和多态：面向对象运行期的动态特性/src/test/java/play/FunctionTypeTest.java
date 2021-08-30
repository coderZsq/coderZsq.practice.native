package play;

import java.util.List;

/**
 * 函数类型
 */
public interface FunctionTypeTest extends TypeTest  {
    public TypeTest getReturnType(); // 返回值类型
    public List<TypeTest> getParamTypes(); // 参数类型
    public boolean matchParameterTypes(List<TypeTest> paramTypes);
}
