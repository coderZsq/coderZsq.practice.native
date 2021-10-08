package mind;

public class DP {
    private static int maxW = Integer.MIN_VALUE; // 结果放到maxW中
    private static int[] weight = {2, 2, 4, 6, 3}; // 物品重量

    private static int maxV = Integer.MIN_VALUE; // 结果放到maxV中
    private static int[] items = {2, 2, 4, 6, 8}; // 物品的重量
    private static int[] value = {3, 4, 8, 9, 6}; // 物品的价值

    private static int n = 5; // 物品个数
    private static int w = 9; // 背包承受的最大重量

    public static void main(String[] args) {
        _01Bag.f(0, 0);
        _01Bag2.f(0, 0);
        System.out.println(maxW);
        System.out.println(_01Bag3.knapsack(weight, n, w));
        System.out.println(_01Bag4.knapsack2(weight, n, w));
        _01Bag5.f(0, 0, 0);
        System.out.println(maxV);
        System.out.println(_01Bag6.knapsack3(items, value, n, w));
    }
    
    // items商品价格，n商品个数, w表示满减条件，比如200
    public static void double11advance(int[] items, int n, int w) {
        boolean[][] states = new boolean[n][3 * w + 1];//超过3倍就没有薅羊毛的价值了
        states[0][0] = true;  // 第一行的数据要特殊处理
        if (items[0] <= 3 * w) {
            states[0][items[0]] = true;
        }
        for (int i = 1; i < n; ++i) { // 动态规划
            for (int j = 0; j <= 3 * w; ++j) {// 不购买第i个商品
                if (states[i - 1][j] == true) states[i][j] = states[i - 1][j];
            }
            for (int j = 0; j <= 3 * w - items[i]; ++j) {//购买第i个商品
                if (states[i - 1][j] == true) states[i][j + items[i]] = true;
            }
        }

        int j;
        for (j = w; j < 3 * w + 1; ++j) {
            if (states[n - 1][j] == true) break; // 输出结果大于等于w的最小值
        }
        if (j == 3 * w + 1) return; // 没有可行解
        for (int i = n - 1; i >= 1; --i) { // i表示二维数组中的行，j表示列
            if (j - items[i] >= 0 && states[i - 1][j - items[i]] == true) {
                System.out.print(items[i] + " "); // 购买这个商品
                j = j - items[i];
            } // else 没有购买这个商品，j不变。
        }
        if (j != 0) System.out.print(items[0]);
    }

    public static class _01Bag {    // 回溯算法实现. 注意: 我把输入的变量都定义成了成员变量
        public static void f(int i, int cw) { // 调用f(0, 0)
            if (cw == w || i == n) { // cw==w表示装满了, i==n表示物品都考察完了
                if (cw > maxW) maxW = cw;
                return;
            }
            f(i + 1, cw); //选择不装第i个物品
            if (cw + weight[i] <= w) {
                f(i + 1, cw + weight[i]); // 选择装第i个物品
            }
        }
    }

    public static class _01Bag2 {    // 回溯算法实现. 注意: 我把输入的变量都定义成了成员变量
        private static boolean[][] mem = new boolean[5][10]; // 备忘录, 默认值false

        public static void f(int i, int cw) { // 调用f(0, 0)
            if (cw == w || i == n) { // cw==w表示装满了, i==n表示物品都考察完了
                if (cw > maxW) maxW = cw;
                return;
            }
            if (mem[i][cw]) return; // 重复状态
            mem[i][cw] = true; // 记录(i, cw)这个状态
            f(i + 1, cw); //选择不装第i个物品
            if (cw + weight[i] <= w) {
                f(i + 1, cw + weight[i]); // 选择装第i个物品
            }
        }
    }

    public static class _01Bag3 {
        // weight:物品重量，n:物品个数，w:背包可承载重量
        public static int knapsack(int[] weight, int n, int w) {
            boolean[][] states = new boolean[n][w + 1]; // 默认值false
            states[0][0] = true;  // 第一行的数据要特殊处理，可以利用哨兵优化
            if (weight[0] <= w) {
                states[0][weight[0]] = true;
            }
            for (int i = 1; i < n; ++i) { // 动态规划状态转移
                for (int j = 0; j <= w; ++j) {// 不把第i个物品放入背包
                    if (states[i - 1][j] == true) states[i][j] = states[i - 1][j];
                }
                for (int j = 0; j <= w - weight[i]; ++j) {//把第i个物品放入背包
                    if (states[i - 1][j] == true) states[i][j + weight[i]] = true;
                }
            }
            for (int i = w; i >= 0; --i) { // 输出结果
                if (states[n - 1][i] == true) return i;
            }
            return 0;
        }
    }

    public static class _01Bag4 {
        public static int knapsack2(int[] items, int n, int w) {
            boolean[] states = new boolean[w + 1]; // 默认值false
            states[0] = true; // 第一行的数据要特殊处理, 可以利用哨兵优化
            if (items[0] <= w) {
                states[items[0]] = true;
            }
            for (int i = 1; i < n; ++i) { // 动态规划
                for (int j = w - items[i]; j >= 0; --j) { // 把第i个物品放入背包
                    if (states[j] == true) states[j + items[i]] = true;
                }
            }
            for (int i = w; i >= 0; --i) { // 输出结果
                if (states[i] == true) return i;
            }
            return 0;
        }
    }

    public static class _01Bag5 {
        public static void f(int i, int cw, int cv) { // 调用f(0, 0, 0)
            if (cw == w || i == n) { // cw==w表示装满了, i==n表示物品都考察完了
                if (cv > maxV) maxV = cv;
                return;
            }
            f(i + 1, cw, cv); // 选择不装第i个物品
            if (cw + items[i] <= w) {
                f(i + 1, cw + items[i], cv + value[i]); // 选择装第i个物品
            }
        }
    }

    public static class _01Bag6 {
        public static int knapsack3(int[] weight, int[] value, int n, int w) {
            int[][] states = new int[n][w + 1];
            for (int i = 0; i < n; ++i) { // 初始化states
                for (int j = 0; j < w + 1; ++j) {
                    states[i][j] = -1;
                }
            }
            states[0][0] = 0;
            if (weight[0] <= w) {
                states[0][weight[0]] = value[0];
            }
            for (int i = 1; i < n; ++i) { // 动态规划, 状态转移
                for (int j = 0; j <= w; ++j) { // 不选择第i个物品
                    if (states[i - 1][j] >= 0) states[i][j] = states[i - 1][j];
                }
                for (int j = 0; j <= w - weight[i]; ++j) { // 选择第i个物品
                    int v = states[i - 1][j] + value[i];
                    if (v > states[i][j + weight[i]]) {
                        states[i][j + weight[i]] = v;
                    }
                }
            }
            // 找出最大值
            int maxvalue = -1;
            for (int j = 0; j <= w; ++j) {
                if (states[n - 1][j] > maxvalue) maxvalue = states[n - 1][j];
            }
            return maxvalue;
        }
    }
}
