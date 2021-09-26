package tree;

public class Tire {

    private TireNode root = new TireNode('/'); // 存储无意义字符

    public static void main(String[] args) {
        Tire tire = new Tire();
        tire.insert("how".toCharArray());
        tire.insert("hi".toCharArray());
        tire.insert("her".toCharArray());
        tire.insert("hello".toCharArray());
        tire.insert("so".toCharArray());
        tire.insert("see".toCharArray());
        System.out.println(tire.find("her".toCharArray()));
        System.out.println(tire.find("he".toCharArray()));
    }

    // 往 Tire 树中插入一个字符串
    public void insert(char[] text) {
        TireNode p = root;
        for (int i = 0; i < text.length; ++i) {
            int index = text[i] - 'a';
            if (p.children[index] == null) {
                TireNode newNode = new TireNode(text[i]);
                p.children[index] = newNode;
            }
            p = p.children[index];
        }
        p.isEndingChar = true;
    }

    // 在 Tire 树种查找一个字符串
    public boolean find(char[] pattern) {
        TireNode p = root;
        for (int i = 0; i < pattern.length; ++i) {
            int index = pattern[i] - 'a';
            if (p.children[index] == null) {
                return false; // 不存在 pattern
            }
            p = p.children[index];
        }
        if (p.isEndingChar == false) return false; // 不能完全匹配, 只是前缀
        else return true; // 找到 pattern
    }

    public class TireNode {
        public char data;
        public TireNode[] children = new TireNode[26];
        public boolean isEndingChar = false;

        public TireNode(char data) {
            this.data = data;
        }
    }
}
