class MinStack {
public:
    /** initialize your data structure here. */
    MinStack() {
    }
    
    void push(int val) {
        // 前缀最小值
        preMin.push(s.empty() ? val : min(val, preMin.top()));
        s.push(val);
    }
    
    void pop() {
        preMin.pop();
        s.pop();
    }
    
    int top() {
        return s.top();
    }
    
    int getMin() {
        return preMin.top();
    }
private:
    stack<int> preMin;
    stack<int> s;
};

/**
 * Your MinStack object will be instantiated and called as such:
 * MinStack* obj = new MinStack();
 * obj->push(val);
 * obj->pop();
 * int param_3 = obj->top();
 * int param_4 = obj->getMin();
 */