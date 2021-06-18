class Solution {
public:
    int calculate(string s) {
        stack<char> ops;
        vector<string> tokens;
        long long val = 0;
        bool num_started = false; // 是否正在parse一个数值，数值后面遇到第一个符号时，要把parse好的数存起来
        bool needs_zero = true; // 是否需要补0，例如 "-48 + +48"，要补成"0-48 + 0+48"
        // leetcode这题不太严谨，官方 "1- -1"的答案是0，即"1-0-1"，而不是1减去负1得2，大家不要在意细节，无脑补0就行了
        for (char ch : s) {
            // Parse一个数值
            if (ch >= '0' && ch <= '9') {
                val = val * 10 + ch - '0';
                num_started = true;
                continue;
            } else if (num_started) { // 数值后面第一次遇到符号
                tokens.push_back(to_string(val));
                num_started = false;
                needs_zero = false; // 加减号跟在数值后面，不需要补0，例如"10-1"
                val = 0;
            }

            if (ch == ' ') continue;
            // 处理运算符
            if (ch == '(') {
                ops.push(ch);
                needs_zero = true; // 加减号跟在左括号后面，需要补零，例如"(-2)*3"变为"(0-2)*3"
                continue;
            }
            if (ch == ')') {
                while (ops.top() != '(') { // 两个括号之间的都可以计算了
                    // push back 包含一个符号的字符串
                    tokens.push_back(string(1, ops.top()));
                    ops.pop();
                }
                ops.pop();
                needs_zero = false; // 加减号跟在右括号后面，不需要补0，例如"3*(1-2)+3"
                continue;
            }
            // 处理+-*/
            if (needs_zero) tokens.push_back("0"); // 补0
            while (!ops.empty() && getRank(ops.top()) >= getRank(ch)) {
                // 前面的符号优先级更高，就可以计算了，例如1*2+3，遇到+时，*就可以算了
                tokens.push_back(string(1, ops.top()));
                ops.pop();
            }
            ops.push(ch);
            needs_zero = true; // +-后面跟着+-号，需要补0，例如"3 + -1"，变为"3 + 0-1"
        }
        if (num_started) tokens.push_back(to_string(val));
        while (!ops.empty()) { // 最后剩余的符号都要取出来
            tokens.push_back(string(1, ops.top()));
            ops.pop();
        }
        return evalRPN(tokens);
    }

    int getRank(char ch) {
        if (ch == '+' || ch == '-') return 1;
        if (ch == '*' || ch == '/') return 2;
        return 0;
    }

    int evalRPN(vector<string>& tokens) {
        stack<long long> s;
        for (string& token : tokens) {
            // is number
            if (token == "+" || token == "-" || token == "*" || token == "/") {
                long long b = s.top();
                s.pop();
                long long a = s.top();
                s.pop();
                s.push(calc(a, b, token)); 
            } else {
                s.push(stoi(token));
            }
        }
        return s.top();
    }

    long long calc(long long a, long long b, string op) {
        if (op == "+") return a + b;
        if (op == "-") return a - b;
        if (op == "*") return a * b;
        if (op == "/") return a / b;
        return 0;
    }
};