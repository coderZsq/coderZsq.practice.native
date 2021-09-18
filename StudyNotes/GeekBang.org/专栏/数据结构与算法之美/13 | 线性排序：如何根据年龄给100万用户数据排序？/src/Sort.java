import java.util.Arrays;

public class Sort {

    public static void main(String[] args) {

        int[] a = {5, 3, 2, 1, 4, 5, 1, 2};
        // bubbleSort(a, a.length);
        // insertionSort(a, a.length);
        // mergeSort(a, a.length);
        // quickSort(a, a.length);
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

    private static void swap(int[] a, int x, int y) {
        int tmp = a[x];
        a[x] = a[y];
        a[y] = tmp;
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
