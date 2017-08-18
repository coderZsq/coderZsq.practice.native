/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit

class HintNode: SKSpriteNode, EventListenerNode {

  func didMoveToScene() {
    color = SKColor.clear

    let shape = SKShapeNode(path: arrowPath)
    shape.strokeColor = SKColor.gray
    shape.lineWidth = 4
    shape.fillColor = SKColor.white
    addChild(shape)

    shape.fillTexture = SKTexture(imageNamed: "wood_tinted")
    shape.alpha = 0.8
    shape.fillColor = SKColor.green
    
    let move = SKAction.moveBy(x: -40, y: 0, duration: 1.0)
    let bounce = SKAction.sequence([
      move, move.reversed()
      ])
    let bounceAction = SKAction.repeat(bounce, count: 3)
    shape.run(bounceAction, completion: {
      self.removeFromParent()
    })
  }

  var arrowPath: CGPath = {
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: 0.5, y: 65.69))
    bezierPath.addLine(to: CGPoint(x: 74.99, y: 1.5))
    bezierPath.addLine(to: CGPoint(x: 74.99, y: 38.66))
    bezierPath.addLine(to: CGPoint(x: 257.5, y: 38.66))
    bezierPath.addLine(to: CGPoint(x: 257.5, y: 92.72))
    bezierPath.addLine(to: CGPoint(x: 74.99, y: 92.72))
    bezierPath.addLine(to: CGPoint(x: 74.99, y: 126.5))
    bezierPath.addLine(to: CGPoint(x: 0.5, y: 65.69))
    bezierPath.close()
    return bezierPath.cgPath
  }()

}
