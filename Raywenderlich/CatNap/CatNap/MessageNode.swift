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

class MessageNode: SKLabelNode {

  convenience init(message: String) {
    self.init(fontNamed: "AvenirNext-Regular")
    text = message
    fontSize = 256.0
    fontColor = SKColor.gray
    zPosition = 100
    let front = SKLabelNode(fontNamed: "AvenirNext-Regular")
    front.text = message
    front.fontSize = 256.0
    front.fontColor = SKColor.white
    front.position = CGPoint(x: -2, y: -2)
    addChild(front)

    physicsBody = SKPhysicsBody(circleOfRadius: 10)
    physicsBody!.collisionBitMask = PhysicsCategory.Edge
    physicsBody!.categoryBitMask = PhysicsCategory.Label
    physicsBody!.contactTestBitMask = PhysicsCategory.Edge
    physicsBody!.restitution = 0.7
  }

  //chapter 9, challenge 1
  private var bounceCount = 0

  func didBounce() {
    bounceCount += 1
    if bounceCount >= 4 {
      removeFromParent()
    }
  }
}
