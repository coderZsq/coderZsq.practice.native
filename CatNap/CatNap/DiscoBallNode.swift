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
import AVFoundation

class DiscoBallNode: SKSpriteNode, EventListenerNode, InteractiveNode {

  private var player: AVPlayer!
  private var video: SKVideoNode!

  func didMoveToScene() {
    isUserInteractionEnabled = true

    let fileUrl = Bundle.main.url(forResource: "discolights-loop", withExtension: "mov")!
    player = AVPlayer(url: fileUrl)
    video = SKVideoNode(avPlayer:player)

    video.size = scene!.size
    video.position = CGPoint(
      x: scene!.frame.midX,
      y: scene!.frame.midY)
    video.zPosition = -1
    scene!.addChild(video)
    video.isHidden = true
    video.pause()

    NotificationCenter.default.addObserver(self,
                                           selector: #selector(didReachEndOfVideo),
                                           name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                           object: nil)

    video.alpha = 0.75
  }

  func interact() {
    if !isDiscoTime {
      isDiscoTime = true
    }
  }

  func didReachEndOfVideo() {
    print("rewind!")
    player.currentItem!.seek(to: kCMTimeZero)
    player.play()
  }

  private var isDiscoTime: Bool = false {
    didSet {
      video.isHidden = !isDiscoTime

      if isDiscoTime {
        video.play()
        run(spinAction)
      } else {
        video.pause()
        removeAllActions()
      }

      SKTAudio.sharedInstance().playBackgroundMusic(
        isDiscoTime ? "disco-sound.m4a" : "backgroundMusic.mp3")

      if isDiscoTime {
        video.run(SKAction.wait(forDuration: 5.0), completion: {
          self.isDiscoTime = false
        })
      }

      DiscoBallNode.isDiscoTime = isDiscoTime
    }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    interact()
  }

  private let spinAction = SKAction.repeatForever(
    SKAction.animate(with: [
      SKTexture(imageNamed: "discoball1"),
      SKTexture(imageNamed: "discoball2"),
      SKTexture(imageNamed: "discoball3")
      ], timePerFrame: 0.2))

  static private(set) var isDiscoTime = false


}
