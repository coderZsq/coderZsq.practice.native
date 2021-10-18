package pop.accessor;

import java.util.List;

public class UnmodifiableList<E> extends UnmodifiableCollection<E> implements List<E> {
    @Override
    public boolean add(E e) {
        throw new UnsupportedOperationException();
    }

    @Override
    public void clear() {
        throw new UnsupportedOperationException();
    }
    // ...省略其他代码...
}
