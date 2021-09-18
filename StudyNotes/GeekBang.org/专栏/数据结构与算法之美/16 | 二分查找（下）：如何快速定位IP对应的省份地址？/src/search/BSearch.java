package search;

public class BSearch {

    public static void main(String[] args) {
        int[] a = {1, 2, 3, 4, 6, 6, 7};
        System.out.println(bsearch(a, a.length, 6));
        System.out.println(bsearch2(a, a.length, 6));
        System.out.println(bsearch3(a, a.length, 6));
    }

    public static int bsearch3(int[] a, int n, int value) {
        int low = 0;
        int high = n - 1;
        while (low <= high) {
            int mid = low + ((high - low) >> 1);
            if (a[mid] > value) {
                high = mid - 1;
            } else if (a[mid] < value) {
                low = mid + 1;
            } else {
                if ((mid == 0) || (a[mid - 1] != value)) return mid;
                else high = mid - 1;
            }
        }
        return -1;
    }

    public static int bsearch2(int[] a, int n, int val) {
        return bsearchInternally(a, 0, a.length, val);
    }

    private static int bsearchInternally(int[] a, int low, int high, int value) {
        if (low > high) return - 1;

        int mid = low + ((high - low) >> 1);
        if (a[mid] == value) {
            return mid;
        } else if (a[mid] < value) {
            return bsearchInternally(a, mid + 1, high, value);
        } else {
            return bsearchInternally(a, low, mid - 1, value);
        }
    }

    public static int bsearch(int[] a, int n, int value) {
        int low = 0;
        int high = n - 1;

        while (low <= high) {
            int mid = (low + high) / 2;
            if (a[mid] == value) {
                return mid;
            } else if (a[mid] < value) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return -1;
    }
}
