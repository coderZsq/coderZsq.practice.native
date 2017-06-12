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
import SceneKit
import SpriteKit

public enum GameStateType {
  case Playing
  case TapToPlay
  case GameOver
}

class GameHelper {
  
  var score:Int
  var highScore:Int
  var lastScore:Int
  var lives:Int
  var state = GameStateType.TapToPlay
  
  var hudNode:SCNNode!
  var labelNode:SKLabelNode!
  
  
  static let sharedInstance = GameHelper()
  
  var sounds:[String:SCNAudioSource] = [:]
  
  private init() {
    score = 0
    lastScore = 0
    highScore = 0
    lives = 3
    let defaults = UserDefaults.standard
    score = defaults.integer(forKey: "lastScore")
    highScore = defaults.integer(forKey: "highScore")
    
    initHUD()
  }
  
  func saveState() {
    
    lastScore = score
    highScore = max(score, highScore)
    let defaults = UserDefaults.standard
    defaults.set(lastScore, forKey: "lastScore")
    defaults.set(highScore, forKey: "highScore")
  }
  
  func getScoreString(_ length:Int) -> String {
    return String(format: "%0\(length)d", score)
  }
  
  func initHUD() {
    
    let skScene = SKScene(size: CGSize(width: 500, height: 100))
    skScene.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
    
    labelNode = SKLabelNode(fontNamed: "Menlo-Bold")
    labelNode.fontSize = 48
    labelNode.position.y = 50
    labelNode.position.x = 250
    
    skScene.addChild(labelNode)
    
    let plane = SCNPlane(width: 5, height: 1)
    let material = SCNMaterial()
    material.lightingModel = SCNMaterial.LightingModel.constant
    material.isDoubleSided = true
    material.diffuse.contents = skScene
    plane.materials = [material]
    
    hudNode = SCNNode(geometry: plane)
    hudNode.name = "HUD"
    hudNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: 3.14159265)
  }
  
  func updateHUD() {
    let scoreFormatted = String(format: "%0\(4)d", score)
    let highScoreFormatted = String(format: "%0\(4)d", highScore)
    labelNode.text = "❤️\(lives)  😎\(highScoreFormatted) 💥\(scoreFormatted)"
  }
  
  func loadSound(_ name:String, fileNamed:String) {
    if let sound = SCNAudioSource(fileNamed: fileNamed) {
      sound.load()
      sounds[name] = sound
    }
  }
  
  func playSound(_ node:SCNNode, name:String) {
    let sound = sounds[name]
    node.runAction(SCNAction.playAudio(sound!, waitForCompletion: false))
  }
  
  func reset() {
    score = 0
    lives = 3
  }
  
  func shakeNode(_ node:SCNNode) {
    let left = SCNAction.move(by: SCNVector3(x: -0.2, y: 0.0, z: 0.0), duration: 0.05)
    let right = SCNAction.move(by: SCNVector3(x: 0.2, y: 0.0, z: 0.0), duration: 0.05)
    let up = SCNAction.move(by: SCNVector3(x: 0.0, y: 0.2, z: 0.0), duration: 0.05)
    let down = SCNAction.move(by: SCNVector3(x: 0.0, y: -0.2, z: 0.0), duration: 0.05)
    
    node.runAction(SCNAction.sequence([
      left, up, down, right, left, right, down, up, right, down, left, up,
      left, up, down, right, left, right, down, up, right, down, left, up]))
  }
  
  
}
