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
    ListNode* reverseList(ListNode* head) {
        ListNode *last = nullptr;
        // 改每条边， 所以需要访问链表
        while (head != nullptr) {
            ListNode *nextHead = head->next;
            // 改一条边
            head->next = last;
            // last,head 向后移一位
            last = head;
            head = nextHead;
        }
        return last;
    }
};