var reverseList = function (head) {
  let prev = null;
  let cur = head;
  while (cur) {
    const tmp = cur.next;
    cur.next = prev;
    prev = cur;
    cur = tmp;
  }
  return prev;
};
