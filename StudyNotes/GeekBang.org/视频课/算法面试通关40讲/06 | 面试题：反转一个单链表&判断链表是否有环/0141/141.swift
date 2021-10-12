class Solution {
    func equals(_ object1: AnyObject?, _ object2: AnyObject?) -> Bool {
        func mem(_ object: AnyObject) -> String {
                return String(describing: Unmanaged<AnyObject>.passUnretained(object).toOpaque())
        }
        guard let object1 = object1, let object2 = object2 else {
            if (object1 == nil && (object2 != nil))
                || (object2 == nil && (object1 != nil)) {
                return false
            }
            return true
        }
        return mem(object1) == mem(object2)
    }
    
    func hasCycle(_ head: ListNode?) -> Bool {
        var slow = head
        var fast = head
        while (slow != nil && fast != nil && fast?.next != nil) {
            slow = slow?.next;
            fast = fast?.next?.next;
            if (equals(slow, fast)) {
                return true
            }
        }
        return false
    }
}