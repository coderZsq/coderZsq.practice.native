func reverseList(head *ListNode) *ListNode {
    var prev *ListNode
    cur := head
    for cur != nil {
        tmp := cur.Next
        cur.Next = prev
        prev = cur
        cur = tmp
    }
    return prev
}