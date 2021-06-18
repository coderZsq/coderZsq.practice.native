class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        int n = 0;
        for (int i = 0; i < nums.size(); i++) {
            if (i == 0 || nums[i] != nums[i - 1]) {
                nums[n] = nums[i];
                n++;
            }
        }
        return n;
    }
};

// 判断这个数要不要