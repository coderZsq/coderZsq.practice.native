package sort;

import java.util.Arrays;

public class MargeSort {

    public static void main(String[] args) {
        int[] a = {5, 3, 2, 1, 4, 5, 1, 2};
        mergeSort(a, a.length);
        System.out.println(Arrays.toString(a));
    }

    public static void mergeSort(int[] a, int n) {
        mergeSortC(a, 0, n - 1);
    }

    private static void mergeSortC(int[] a, int p, int r) {
        if (p >= r) return;

        int q = (p + r) / 2;
        mergeSortC(a, p, q);
        mergeSortC(a, q + 1, r);
        merge(a, p, q, r);
    }

    private static void merge(int[] a, int p, int q, int r) {
        int i = p, j = q + 1, k = 0;
        int[] tmp = new int[r - p + 1];
        while (i <= q && j <= r) {
            if (a[i] <= a[j]) {
                tmp[k++] = a[i++];
            } else {
                tmp[k++] = a[j++];
            }
        }

        int start = i, end = q;
        if (j <= r) {
            start = j;
            end = r;
        }

        while (start <= end) {
            tmp[k++] = a[start++];
        }

        for (i = 0; i <= r - p; i++) {
            a[p + i] = tmp[i];
        }
    }
}
