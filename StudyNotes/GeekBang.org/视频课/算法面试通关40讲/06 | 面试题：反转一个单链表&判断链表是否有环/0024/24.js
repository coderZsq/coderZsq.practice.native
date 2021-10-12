var swapPairs = function (head) {
  const dummy = new ListNode();
  dummy.next = head;
  let pre = dummy;
  while (pre.next && pre.next.next) {
    const a = pre.next;
    const b = pre.next.next;
    const tmp = b.next;
    pre.next = b;
    b.next = a;
    a.next = tmp;
    pre = a;
  }
  return dummy.next;
};
