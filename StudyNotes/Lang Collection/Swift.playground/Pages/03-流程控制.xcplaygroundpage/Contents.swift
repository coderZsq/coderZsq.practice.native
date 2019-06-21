var age = 10

for _ in 0...3 {
    print("123")
}

let str = "a"
let a: Character = "a"
let z: Character = "z"
let range = a...z

switch age {
case 1:
    fallthrough
case 2:
    print("1 2")
default:
    print("other")
}

var numbers = [-1, 2]
for num in numbers where num > 0 {
    print(num)
}
