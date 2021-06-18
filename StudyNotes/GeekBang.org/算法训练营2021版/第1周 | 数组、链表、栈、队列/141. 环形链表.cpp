/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    bool hasCycle(ListNode *head) {
        ListNode *fast = head;
        while (fast != nullptr && fast->next != nullptr) {
            fast = fast->next->next;
            head = head->next;
            if (fast == head) return true;
        }
        return false;
    }
};