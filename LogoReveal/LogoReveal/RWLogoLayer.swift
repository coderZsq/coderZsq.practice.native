/*
* Copyright (c) 2014-2016 Razeware LLC
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

import UIKit
import QuartzCore

class RWLogoLayer {
  
  //
  // Function to create a RW logo shape layer
  //
  class func logoLayer() -> CAShapeLayer {
    let layer = CAShapeLayer()
    layer.isGeometryFlipped = true
    
    //the RW bezier
    let bezier = UIBezierPath()
    bezier.move(to: CGPoint(x: 0.0, y: 0.0))
    bezier.addCurve(to: CGPoint(x: 0.0, y: 66.97), controlPoint1:CGPoint(x: 0.0, y: 0.0), controlPoint2:CGPoint(x: 0.0, y: 57.06))
    bezier.addCurve(to: CGPoint(x: 16.0, y: 39.0), controlPoint1: CGPoint(x: 27.68, y: 66.97), controlPoint2:CGPoint(x: 42.35, y: 52.75))
    bezier.addCurve(to: CGPoint(x: 26.0, y: 17.0), controlPoint1: CGPoint(x: 17.35, y: 35.41), controlPoint2:CGPoint(x: 26, y: 17))
    bezier.addLine(to: CGPoint(x: 38.0, y: 34.0))
    bezier.addLine(to: CGPoint(x: 49.0, y: 17.0))
    bezier.addLine(to: CGPoint(x: 67.0, y: 51.27))
    bezier.addLine(to: CGPoint(x: 67.0, y: 0.0))
    bezier.addLine(to: CGPoint(x: 0.0, y: 0.0))
    bezier.close()
    
    //create a shape layer
    layer.path = bezier.cgPath
    layer.bounds = (layer.path?.boundingBox)!
    
    return layer
  }
  
}
