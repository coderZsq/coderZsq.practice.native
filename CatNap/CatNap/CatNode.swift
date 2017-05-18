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

class CatNode: SKSpriteNode, EventListenerNode, InteractiveNode {

  static let kCatTappedNotification = "kCatTappedNotification"

  func didMoveToScene() {
    print("cat added to scene")

    let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
    parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture, size: catBodyTexture.size())

    parent!.physicsBody!.categoryBitMask = PhysicsCategory.Cat
    parent!.physicsBody!.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Edge | PhysicsCategory.Spring
    parent!.physicsBody!.contactTestBitMask = PhysicsCategory.Bed | PhysicsCategory.Edge

    isUserInteractionEnabled = true
  }

  func wakeUp() {
    // 1
    for child in children {
      child.removeFromParent()
    }
    texture = nil
    color = SKColor.clear
    // 2
    let catAwake = SKSpriteNode(fileNamed: "CatWakeUp")!.childNode(withName: "cat_awake")!
    // 3
    catAwake.move(toParent: self)
    catAwake.position = CGPoint(x: -30, y: 100)
  }

  func curlAt(scenePoint: CGPoint) {
    parent!.physicsBody = nil
    for child in children {
      child.removeFromParent()
    }
    texture = nil
    color = SKColor.clear

    let catCurl = SKSpriteNode(fileNamed: "CatCurl")!.childNode(withName: "cat_curl")!
    catCurl.move(toParent: self)
    catCurl.position = CGPoint(x: -30, y: 100)

    var localPoint = parent!.convert(scenePoint, from: scene!)
    localPoint.y += frame.size.height/3

    run(SKAction.group([
      SKAction.move(to: localPoint, duration: 0.66),
      SKAction.rotate(toAngle: -parent!.zRotation, duration: 0.5)
      ]))
  }

  func interact() {
    NotificationCenter.default.post(Notification(name:
      NSNotification.Name(CatNode.kCatTappedNotification), object: nil))

    if DiscoBallNode.isDiscoTime && !isDoingTheDance {
      isDoingTheDance = true
      let move = SKAction.sequence([
        SKAction.moveBy(x: 80, y: 0, duration: 0.5),
        SKAction.wait(forDuration: 0.5),
        SKAction.moveBy(x: -30, y: 0, duration: 0.5)
        ])
      let dance = SKAction.repeat(move, count: 3)
      parent!.run(dance, completion: {
        self.isDoingTheDance = false
      })
    }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    interact()
  }

  private var isDoingTheDance = false


}
