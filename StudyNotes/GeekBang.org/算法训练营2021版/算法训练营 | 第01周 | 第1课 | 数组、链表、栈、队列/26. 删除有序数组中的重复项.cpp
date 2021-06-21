class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        int n = 0;
        // 主题思路：保留与上一个不一样的
        // 细节判断：i-1不能越界，第0个肯定要
        for (int i = 0; i < nums.size(); i++) {
            if (i == 0 || nums[i] != nums[i - 1]) {
                nums[n] = nums[i];
                n++;
            }
        }
        return n;
    }
};