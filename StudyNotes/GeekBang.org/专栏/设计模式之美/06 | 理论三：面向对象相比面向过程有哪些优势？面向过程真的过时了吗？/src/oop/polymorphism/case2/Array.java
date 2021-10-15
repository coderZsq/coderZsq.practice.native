package oop.polymorphism.case2;

public class Array implements Iterator {
    private String[] data;

    @Override
    public boolean hasNext() {
        return false;
    }

    @Override
    public String next() {
        return null;
    }

    @Override
    public String remove() {
        return null;
    }
    //...省略其他方法...
}