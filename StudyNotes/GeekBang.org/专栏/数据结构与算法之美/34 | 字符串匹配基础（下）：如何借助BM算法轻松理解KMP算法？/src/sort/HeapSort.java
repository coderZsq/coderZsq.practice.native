package sort;

import tree.Heap;

import java.util.Arrays;

public class HeapSort {

    public static void main(String[] args) {
        int[] a = {666, 5, 3, 2, 1, 4, 5, 1, 2};
        heapSort(a, a.length - 1);
        System.out.println(Arrays.toString(a));
    }

    public static void heapSort(int[] a, int n) {
        Heap.sort(a, n);
    }
}
