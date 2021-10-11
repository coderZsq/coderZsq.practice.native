package sort;

import java.util.Arrays;

public class CountingSort {

    public static void main(String[] args) {
        int[] a = {5, 3, 2, 1, 4, 5, 1, 2};
        countingSort(a, a.length);
        System.out.println(Arrays.toString(a));
    }

    public static void countingSort(int[] a, int n) {
        if (n <= 1) return;

        int max = a[0];
        for (int i = 1; i < n; ++i) {
            if (max < a[i]) {
                max = a[i];
            }
        }

        int[] c = new int[max + 1];
        for (int i = 0; i <= max; ++i) {
            c[i] = 0;
        }

        for (int i = 0; i < n; ++i) {
            c[a[i]]++;
        }

        for (int i = 1; i <= max; ++i) {
            c[i] = c[i - 1] + c[i];
        }

        int[] r = new int[n];
        for (int i = n - 1; i >= 0; --i) {
            int index = c[a[i]] - 1;
            r[index] = a[i];
            c[a[i]]--;
        }

        for (int i = 0; i < n; ++i) {
            a[i] = r[i];
        }
    }
}
