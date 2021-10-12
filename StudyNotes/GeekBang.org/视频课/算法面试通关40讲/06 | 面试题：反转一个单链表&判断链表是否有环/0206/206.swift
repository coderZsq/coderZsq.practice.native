class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        var prev: ListNode?
        var cur = head
        while (cur != nil) {
            let tmp = cur?.next;
            cur?.next = prev
            prev = cur
            cur = tmp
        }
        return prev
    }
}
