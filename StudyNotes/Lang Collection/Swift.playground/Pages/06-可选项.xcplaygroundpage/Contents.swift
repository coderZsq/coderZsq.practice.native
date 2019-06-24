var num = Int("kkk123")

enum Season : Int {
    case spring, summer, autumn, winter
}

var s = Season(rawValue: 2)

var dict = ["age" : 10]
var age = dict["abc"]

// 隐式解包的可选项
let num1: Int! = 10
let num2: Int = num1

var age1: Int? = 10
print("my age is \(String(describing: age))")

var num3: Int? = nil
var num4: Int?? = num3
var num5: Int?? = nil
print(num4 == num5)
print(num3 == num5)
