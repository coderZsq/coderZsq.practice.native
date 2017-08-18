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

protocol EventListenerNode {
  func didMoveToScene()
}
protocol InteractiveNode {
  func interact()
}

struct PhysicsCategory {
  static let None:  UInt32 = 0
  static let Cat:   UInt32 = 0b1 // 1
  static let Block: UInt32 = 0b10 // 2
  static let Bed:   UInt32 = 0b100 // 4
  static let Edge:  UInt32 = 0b1000 // 8
  static let Label: UInt32 = 0b10000 // 16
  static let Spring:UInt32 = 0b100000 // 32
  static let Hook:  UInt32 = 0b1000000 // 64
}

class GameScene: SKScene, SKPhysicsContactDelegate {

  var bedNode: BedNode!
  var catNode: CatNode!

  var playable = true

  override func didMove(to view: SKView) {
    // Calculate playable margin
    let maxAspectRatio: CGFloat = 16.0/9.0
    let maxAspectRatioHeight = size.width / maxAspectRatio
    let playableMargin: CGFloat = (size.height - maxAspectRatioHeight)/2
    let playableRect = CGRect(x: 0, y: playableMargin,
                              width: size.width, height: size.height-playableMargin*2)
    physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
    physicsWorld.contactDelegate = self
    physicsBody!.categoryBitMask = PhysicsCategory.Edge

    enumerateChildNodes(withName: "//*", using: { node, _ in
      if let eventListenerNode = node as? EventListenerNode {
        eventListenerNode.didMoveToScene()
      }
    })

    bedNode = childNode(withName: "bed") as! BedNode
    catNode = childNode(withName: "//cat_body") as! CatNode

    SKTAudio.sharedInstance().playBackgroundMusic("backgroundMusic.mp3")

//    let rotationConstraint = SKConstraint.zRotation(
//      SKRange(lowerLimit: -π/4, upperLimit: π/4))
//    catNode.parent!.constraints = [rotationConstraint]

    hookBaseNode = childNode(withName: "hookBase") as? HookBaseNode

  }

  func didBegin(_ contact: SKPhysicsContact) {
    let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

    if collision == PhysicsCategory.Label | PhysicsCategory.Edge {

      let labelNode = contact.bodyA.categoryBitMask == PhysicsCategory.Label ?
        contact.bodyA.node :
        contact.bodyB.node

      if let message = labelNode as? MessageNode {
        message.didBounce()
      }
    }

    if !playable {
      return
    }
    
    if collision == PhysicsCategory.Cat | PhysicsCategory.Bed {
      print("SUCCESS")
      win()
    } else if collision == PhysicsCategory.Cat | PhysicsCategory.Edge {
      print("FAIL")
      lose()
    }

    if collision == PhysicsCategory.Cat | PhysicsCategory.Hook
      && hookBaseNode?.isHooked == false {
      hookBaseNode!.hookCat(catPhysicsBody:
        catNode.parent!.physicsBody!)
    }

    
  }

  func inGameMessage(text: String) {
    let message = MessageNode(message: text)
    message.position = CGPoint(x: frame.midX, y: frame.midY)
    addChild(message)
  }

  func newGame() {
    view!.presentScene(GameScene.level(levelNum: currentLevel))
  }

  func lose() {
    if currentLevel > 1 {
      currentLevel -= 1
    }
    
    playable = false
    //1
    SKTAudio.sharedInstance().pauseBackgroundMusic()
    SKTAudio.sharedInstance().playSoundEffect("lose.mp3")
    //2
    inGameMessage(text: "Try again...")
    //3
    perform(#selector(newGame), with: nil, afterDelay: 5)

    catNode.wakeUp()
  }

  func win() {
    if currentLevel < 6 {
      currentLevel += 1
    }

    playable = false
    SKTAudio.sharedInstance().pauseBackgroundMusic()
    SKTAudio.sharedInstance().playSoundEffect("win.mp3")
    inGameMessage(text: "Nice job!")
    perform(#selector(GameScene.newGame), with: nil, afterDelay: 3)

    catNode.curlAt(scenePoint: bedNode.position)
  }

  override func didSimulatePhysics() {
    if playable && hookBaseNode?.isHooked != true {
      if fabs(catNode.parent!.zRotation) >
        CGFloat(25).degreesToRadians() {
        lose() }
    }
  }

  //1
  var currentLevel: Int = 0

  //2
  class func level(levelNum: Int) -> GameScene? {
    let scene = GameScene(fileNamed: "Level\(levelNum)")!
    scene.currentLevel = levelNum
    scene.scaleMode = .aspectFill
    return scene
  }

  var hookBaseNode: HookBaseNode?

}
