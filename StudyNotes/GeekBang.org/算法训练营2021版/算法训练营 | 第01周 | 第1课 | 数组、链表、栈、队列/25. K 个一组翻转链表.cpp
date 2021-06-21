/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode() : val(0), next(nullptr) {}
 *     ListNode(int x) : val(x), next(nullptr) {}
 *     ListNode(int x, ListNode *next) : val(x), next(next) {}
 * };
 */
class Solution {
public:
    ListNode* reverseKGroup(ListNode* head, int k) {
        ListNode *protect = new ListNode(0, head);
        // 分组（找到每一组的开始、结尾），按组遍历
        // last = 上一组结尾
        ListNode *last = protect;
        while (head != nullptr) {
            ListNode *end = getEnd(head, k);
            if (end == nullptr) {
                break;
            }
            ListNode *nextGroupHead = end->next;
            // 处理head到end之间的k-1条边的反转
            reverseList(head, end);
            // 上一组跟本组的新开始（旧end）建立联系
            last->next = end;
            // 本组的新结尾（head）跟下一组建立联系
            head->next = nextGroupHead;

            // 分组遍历
            last = head;
            head = nextGroupHead;
        }
        return protect->next;
    }

private:
    ListNode* getEnd(ListNode* head, int k) {
        while (head != nullptr) {          
            k--;
            if (k == 0) break;
            head = head->next;
        }
        return head;
    }

    // head到end之间反过来
    void reverseList(ListNode* head, ListNode* end) {
        if (head == end) return;
        ListNode *last = head;
        head = head->next;
        // 改每条边，所以需要访问链表
        while (head != end) {
            ListNode *nextHead = head->next;
            // 改一条边
            head->next = last;
            // last,head向后移动一位
            last = head;
            head = nextHead;
        }
        end->next = last;
    }
};