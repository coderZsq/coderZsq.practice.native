func swapPairs(head *ListNode) *ListNode {
    dummy := new(ListNode)
    dummy.Next = head
    pre := dummy
    for pre.Next != nil && pre.Next.Next != nil {
        a := pre.Next
        b := pre.Next.Next
        pre.Next, b.Next, a.Next = b, a, b.Next
        pre = a
    }
    return dummy.Next
}