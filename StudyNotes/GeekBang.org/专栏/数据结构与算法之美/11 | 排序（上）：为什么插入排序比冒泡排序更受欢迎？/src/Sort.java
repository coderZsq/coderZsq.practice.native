import java.util.Arrays;

public class Sort {

    public static void main(String[] args) {

        int[] a = {5, 3, 2, 1, 4, 5, 1, 2};
        // bubbleSort(a, a.length);
        insertionSort(a, a.length);
        System.out.println(Arrays.toString(a));
    }

    public static void bubbleSort(int[] a, int n) {
        if (n <= 1) return;

        for (int i = 0; i < n; ++i) {
            boolean flag = false;
            for (int j = 0; j < n - i - 1; ++j) {
                if (a[j] > a[j + 1]) {
                    int tmp = a[j];
                    a[j] = a[j + 1];
                    a[j + 1] = tmp;
                    flag = true;
                }
            }
            if (!flag) break;
        }
    }

    public static void insertionSort(int[] a, int n) {
        if (n <= 1) return;

        for (int i = 0; i < n; ++i) {
            int value = a[i];
            int j = i - 1;

            for (; j >= 0; --j) {
                if (a[j] > value) {
                    a[j + 1] = a[j];
                } else {
                    break;
                }
            }

            a[j + 1] = value;
        }
    }
}
