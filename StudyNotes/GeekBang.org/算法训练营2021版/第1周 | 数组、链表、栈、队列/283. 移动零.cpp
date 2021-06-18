class Solution {
public:
    void moveZeroes(vector<int>& nums) {
        int n = 0;
        // 主题思路：保留非零值
        for (int i = 0; i < nums.size(); i++) {
            if (nums[i] != 0) {
                nums[n] = nums[i];
                n++;
            }
        }
        // 按题目要求，最后面填充零
        while (n < nums.size()) {
            nums[n] = 0;
            n++;
        }
    }
};