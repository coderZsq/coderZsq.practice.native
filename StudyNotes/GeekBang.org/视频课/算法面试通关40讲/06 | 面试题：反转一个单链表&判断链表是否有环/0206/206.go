func reverseList(head *ListNode) *ListNode {
    var prev *ListNode
    cur := head
    for cur != nil {
        cur.Next, prev, cur = prev, cur, cur.Next
    }
    return prev
}