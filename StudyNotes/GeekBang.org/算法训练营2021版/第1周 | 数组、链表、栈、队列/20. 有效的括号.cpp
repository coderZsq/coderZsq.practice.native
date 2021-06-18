class Solution {
public:
    bool isValid(string s) {
        std::stack<char> st;
        for (char ch : s) {
            if (ch == '(') st.push(')');
            else if (ch == '[') st.push(']');
            else if (ch == '{') st.push('}');
            else if (!st.empty() && ch == st.top()) st.pop();
            else return false;
        }
        return st.empty();
    }
};