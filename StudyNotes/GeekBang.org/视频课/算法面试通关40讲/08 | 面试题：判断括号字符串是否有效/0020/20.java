class Solution {
    public boolean isValid(String s) {
        char[] chars = s.toCharArray();
        Stack<Character> stack = new Stack<>();
        Map<Character, Character> paren_map = new HashMap<>();
        paren_map.put(')', '(');
        paren_map.put(']', '[');
        paren_map.put('}', '{');
        for (int i = 0; i < chars.length; i++) {
            Character c = chars[i];
            if (!paren_map.containsKey(c)) {
                stack.push(c);
            } else if (stack.isEmpty() || !paren_map.get(c).equals(stack.pop())) {
                return false;
            }
        }
        return stack.isEmpty();
    }
}