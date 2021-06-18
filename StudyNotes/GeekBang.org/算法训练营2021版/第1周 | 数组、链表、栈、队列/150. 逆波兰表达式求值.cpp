class Solution {
public:
    int evalRPN(vector<string>& tokens) {
        stack<long long> s;
        for (string& token : tokens) {
            // 是运算符，取出栈顶两个操作数，运算结果入栈
            if (token == "+" || token == "-" || token == "*" || token == "/") {
                long long b = s.top();
                s.pop();
                long long a = s.top();
                s.pop();
                s.push(calc(a, b, token)); 
            } else {
                // 操作数入栈
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