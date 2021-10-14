func isValid(s string) bool {
	stack := []byte{}
	paren_map := map[byte]byte{')': '(', ']': '[', '}': '{'}
	for i := 0; i < len(s); i++ {
		c := s[i]
		if _, ok := paren_map[c]; !ok {
			stack = append(stack, c)
		} else if len(stack) == 0 || paren_map[c] != stack[len(stack)-1] {
			return false
		} else {
      stack = stack[:len(stack)-1]
    }
	}
	return len(stack) == 0
}