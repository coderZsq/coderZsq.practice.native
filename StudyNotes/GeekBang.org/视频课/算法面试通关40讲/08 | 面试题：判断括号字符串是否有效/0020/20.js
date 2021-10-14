var isValid = function (s) {
  const stack = [];
  const paren_map = new Map([
    [")", "("],
    ["]", "["],
    ["}", "{"],
  ]);
  for (let c of s) {
    if (!paren_map.has(c)) {
      stack.push(c);
    } else if (!stack.length || paren_map.get(c) !== stack.pop()) {
      return false;
    }
  }
  return !stack.length;
};
