class Solution {
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let dummy = ListNode()
        dummy.next = head
        var pre = dummy
        while ((pre.next != nil) && ((pre.next?.next) != nil)) {
            let a = pre.next;
            let b = pre.next?.next;
            let tmp = b?.next;
            pre.next = b;
            b?.next = a;
            a?.next = tmp;
            pre = a ?? pre;
        }
        return dummy.next;
    }
}