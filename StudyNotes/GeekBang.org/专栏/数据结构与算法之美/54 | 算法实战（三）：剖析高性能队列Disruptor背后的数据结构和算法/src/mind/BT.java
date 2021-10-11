package mind;

public class BT {

    public static class Pattern {
        private boolean matched = false;
        private char[] pattern; // 正则表达式
        private int plen; // 正则表达式长度

        public Pattern(char[] pattern, int plen) {
            this.pattern = pattern;
            this.plen = plen;
        }

        public boolean match(char[] text, int tlen) { // 文本串及长度
            matched = false;
            rmatch(0, 0, text, tlen);
            return matched;
        }

        private void rmatch(int ti, int pj, char[] text, int tlen) {
            if (matched) return; // 如果已经匹配了, 就不要继续帝国了
            if (pj == plen) { // 正则表达式到结尾了
                if (ti == tlen) matched = true; // 文本串也到结尾了
                return;
            }
            if (pattern[pj] == '*') { // *匹配任意个字符
                for (int k = 0; k <= tlen - ti; ++k) {
                    rmatch(ti + k, pj + 1, text, tlen);
                }
            } else if (pattern[pj] == '?') { // ? 匹配 0 个或者 1 个字符
                rmatch(ti, pj + 1, text, tlen);
                rmatch(ti + 1, pj + 1, text, tlen);
            } else if (ti < tlen && pattern[pj] == text[ti]) { // 纯字符匹配才行
                rmatch(ti + 1, pj + 1, text, tlen);
            }
        }
    }

    public static class _01Bag {

        public static int maxW = Integer.MIN_VALUE; // 存储背包中物品总重量的最大值

        public static void main(String[] args) {
            int[] a = new int[]{33, 33, 33, 33, 33, 33, 33, 33, 33, 33};
            f(0, 0, a, 10, 100);
            System.out.println(maxW);
        }

        // cw表示当前已经装进去的物品的重量和；i表示考察到哪个物品了；
        // w背包重量；items表示每个物品的重量；n表示物品个数
        // 假设背包可承受重量100，物品个数10，物品重量存储在数组a中，那可以这样调用函数：
        // f(0, 0, a, 10, 100)
        public static void f(int i, int cw, int[] items, int n, int w) {
            if (cw == w || i == n) { // cw==w表示装满了;i==n表示已经考察完所有的物品
                if (cw > maxW) maxW = cw;
                return;
            }
            f(i + 1, cw, items, n, w);
            if (cw + items[i] <= w) {// 已经超过可以背包承受的重量的时候，就不要再装了
                f(i + 1, cw + items[i], items, n, w);
            }
        }
    }

    public static class _8Queens {

        static int[] result = new int[8]; // 全局或成员变量, 下标表示行, 值表示 queen 存储在哪一列

        public static void main(String[] args) {
            cal8queens(0);
        }

        public static void cal8queens(int row) { // 调用方式: cal8queens(0)
            if (row == 8) { // 8 个棋子都放置好了, 打印结果
                printQueens(result);
                return; // 8 行棋子都放好了, 已经没法再往下递归了, 所以就 return
            }
            for (int column = 0; column < 8; ++column) { // 每一行都有 8 种放法
                if (isOk(row, column)) { // 有些方法不满足要求
                    result[row] = column; // 第 row 行的棋子放到了 column 列
                    cal8queens(row + 1); // 考察下一行
                }
            }
        }

        private static boolean isOk(int row, int column) { // 判断 row 行 column 列放置是否合适
            int leftup = column - 1, rightup = column + 1;
            for (int i = row - 1; i >= 0; --i) { // 逐行往上考察每一行
                if (result[i] == column) return false; // 第 i 行的 column 列有棋子吗?
                if (leftup >= 0) { // 考察左上对角线: 第 i 行 leftup 列有棋子吗?
                    if (result[i] == leftup) return false;
                }
                if (rightup < 8) { // 考察右上对角线: 第 i 行 rightup 列有棋子吗?
                    if (result[i] == rightup) return false;
                }
                --leftup;
                ++rightup;
            }
            return true;
        }

        private static void printQueens(int[] result) { // 打印出一个二维矩阵
            for (int row = 0; row < 8; ++row) {
                for (int column = 0; column < 8; ++column) {
                    if (result[row] == column) System.out.print("Q ");
                    else System.out.print("* ");
                }
                System.out.println();
            }
            System.out.println();
        }
    }
}
