func swapPairs(head *ListNode) *ListNode {
    dummy := new(ListNode)
    dummy.Next = head
    pre := dummy
    for pre.Next != nil && pre.Next.Next != nil {
        a := pre.Next
        b := pre.Next.Next
        tmp := b.Next
        pre.Next = b
        b.Next = a
        a.Next = tmp
        pre = a
    }
    return dummy.Next
}