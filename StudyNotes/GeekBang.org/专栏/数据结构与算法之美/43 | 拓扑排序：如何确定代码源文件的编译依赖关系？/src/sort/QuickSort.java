package sort;

import java.util.Arrays;

import static utils.Utils.swap;

public class QuickSort {

    public static void main(String[] args) {
        int[] a = {5, 3, 2, 1, 4, 5, 1, 2};
        quickSort(a, a.length);
        System.out.println(Arrays.toString(a));
    }

    public static void quickSort(int[] a, int n) {
        quickSortC(a, 0, n - 1);
    }

    private static void quickSortC(int[] a, int p, int r) {
        if (p >= r) return;;

        int q = partition(a, p, r);
        quickSortC(a, p, q - 1);
        quickSortC(a, q + 1, r);
    }

    private static int partition(int[] a, int p, int r) {
        int pivot = a[r];
        int i = p;
        for (int j = p; j <= r - 1; j++) {
            if (a[j] < pivot) {
                swap(a, i, j);
                i++;
            }
        }
        swap(a, i, r);
        return i;
    }
}
