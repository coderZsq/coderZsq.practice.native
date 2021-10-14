package oop.polymorphism.case2;

public class LinkedList implements Iterator {
    private LinkedListNode head;

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