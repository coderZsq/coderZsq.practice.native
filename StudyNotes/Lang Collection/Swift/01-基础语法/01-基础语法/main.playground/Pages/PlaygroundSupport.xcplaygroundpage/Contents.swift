let a = 10
let b = 10
var c = a + b
c += 10
c += 20
print(c)

import UIKit
import PlaygroundSupport

let view = UIView()
view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
view.backgroundColor = UIColor.red

var str = "Hello, playground"
PlaygroundPage.current.liveView = view

let imageView = UIImageView(image: UIImage(named: "logo"))
PlaygroundPage.current.liveView = imageView

let vc = UITableViewController()
vc.view.backgroundColor = UIColor.lightGray
PlaygroundPage.current.liveView = vc

