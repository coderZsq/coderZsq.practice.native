class Solution {
public:
    ListNode* swapPairs(ListNode* head) {
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* pre = dummy;
        while (pre->next != nullptr && pre->next->next != nullptr) {
            ListNode* a = pre->next;
            ListNode* b = pre->next->next;
            ListNode* tmp = b->next;
            pre->next = b;
            b->next = a;
            a->next = tmp;
            pre = a;
        }
        return dummy->next;
    }
};