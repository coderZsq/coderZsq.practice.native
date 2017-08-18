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

import SceneKit
import Foundation

extension SCNAction {
  
  class func waitForDurationThenRemoveFromParent(_ duration:TimeInterval) -> SCNAction {
    let wait = SCNAction.wait(duration: duration)
    let remove = SCNAction.removeFromParentNode()
    return SCNAction.sequence([wait,remove])
  }
  
  class func waitForDurationThenRunBlock(_ duration:TimeInterval, block: @escaping ((SCNNode!) -> Void) ) -> SCNAction {
    let wait = SCNAction.wait(duration: duration)
    let runBlock = SCNAction.run { (node) -> Void in
      block(node)
    }
    return SCNAction.sequence([wait,runBlock])
  }
  
  class func rotateByXForever(_ x:CGFloat, y:CGFloat, z:CGFloat, duration:TimeInterval) -> SCNAction {
    let rotate = SCNAction.rotateBy(x: x, y: y, z: z, duration: duration)
    return SCNAction.repeatForever(rotate)
  }
  
}
