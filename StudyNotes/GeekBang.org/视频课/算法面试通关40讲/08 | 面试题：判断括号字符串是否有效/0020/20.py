class Solution:
    def isValid(self, s: str) -> bool:
        stack = []
        paren_map = {')': '(', ']': '[', '}': '{'}
        for c in s:
            if c not in paren_map:
                stack.append(c)
            elif not stack or paren_map[c] != stack.pop():
                return False
        return not stack