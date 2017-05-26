/**
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

import Foundation
import SpriteKit

protocol Animatable: class  {
  var animations: [SKAction] {get set}
}

extension Animatable {
  func animationDirection(for directionVector: CGVector)
    -> Direction {
      let direction: Direction
      if abs(directionVector.dy) > abs(directionVector.dx) {
        direction = directionVector.dy < 0 ? .forward : .backward
      } else {
        direction = directionVector.dx < 0 ? .left : .right
      }
      
      return direction
  }
  
  func createAnimations(character: String) {
    let actionForward: SKAction = SKAction.animate(with: [
      SKTexture(pixelImageNamed: "\(character)_ft1"),
      SKTexture(pixelImageNamed: "\(character)_ft2")
      ], timePerFrame: 0.2)
    animations.append(SKAction.repeatForever(actionForward))
    
    let actionBackward: SKAction = SKAction.animate(with: [
      SKTexture(pixelImageNamed: "\(character)_bk1"),
      SKTexture(pixelImageNamed: "\(character)_bk2")
      ], timePerFrame: 0.2)
    animations.append(SKAction.repeatForever(actionBackward))
    
    let actionLeft: SKAction = SKAction.animate(with: [
      SKTexture(pixelImageNamed: "\(character)_lt1"),
      SKTexture(pixelImageNamed: "\(character)_lt2")
      ], timePerFrame: 0.2)
    animations.append(SKAction.repeatForever(actionLeft))
    
    animations.append(SKAction.repeatForever(actionLeft))
  }

}
