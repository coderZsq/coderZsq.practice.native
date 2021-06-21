class Solution {
public:
    int numberOfSubarrays(vector<int>& nums, int k) {
        // 下标变成1~n
        nums.insert(nums.begin(), 0);

        // nums = [1,3,2,1,1] 对2取模
        // nums = [1,1,0,1,1] 只有1和0
        // 有多少个连续子数组（子段），子段和是k
        vector<int> s(nums.size(), 0);
        for (int i = 1; i < nums.size(); i++) { // for i = 1 ~ n
            s[i] = s[i - 1] + nums[i] % 2;
        }
        
        // 先把r,l两个循环变量分离
        // for r = 1 ~ n
        //   for l = 1 ~ r // [l,r]这个子段
        //      if s[r] - s[l-1] == k:
        //        ans += 1

        // 固定外层循环变量，考虑内层满足什么条件
        // 对于每个r (1~n),考虑有几个l (1~r)，使得s[r]-s[l-1]=k
        //                                      i     j
        // 对于每个i (1~n),考虑有几个j (0~i-1)，使得s[i]-s[j]=k
        // 对于每个i (1~n),考虑有几个j (0~i-1)，使得s[j]=s[i]-k
        // 对于每个i，有几个s[j]等于s[i]-k

        // 在一个数组(s)中统计“等于某个数”的数的数量
        // 长度为n的计数数组count
        // s = [0, 1, 2, 2, 3, 3, 4]
        // count = [1, 1, 2, 2, 1]
        // 1个0， 1个1，2个2，2个3，2个4

        // C++/Java 用map, python用dict，JS用{}, 也可以count
        // nums = [2,4,6]
        // nums = [0,0,0]
        
        vector<int> count(s.size(), 0);
        for (int i = 0; i < s.size(); i++) { // for i = 0 ~ n
            count[s[i]] += 1;
        }

        // 对于每个i，有几个s[j]等于s[i]-k
        int ans = 0;
        for (int i = 1; i < s.size(); i++) { // for i = 1 ~ n
            if (s[i] - k >= 0) {
                ans += count[s[i] - k];
            }
        }
        return ans;
    }
};