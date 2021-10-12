def reverseList(self, head):
  cur, prev = head, None
  while cur: 
    cur.next, prev, cur = prev, cur, cur.next
  return prev