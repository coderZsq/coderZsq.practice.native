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

// A delay function
func delay(seconds: Double, completion: @escaping ()-> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class ViewController: UIViewController {

  enum AnimationDirection: Int {
    case positive = 1
    case negative = -1
  }
  
  @IBOutlet var bgImageView: UIImageView!
  
  @IBOutlet var summaryIcon: UIImageView!
  @IBOutlet var summary: UILabel!
  
  @IBOutlet var flightNr: UILabel!
  @IBOutlet var gateNr: UILabel!
  @IBOutlet var departingFrom: UILabel!
  @IBOutlet var arrivingTo: UILabel!
  @IBOutlet var planeImage: UIImageView!
  
  @IBOutlet var flightStatus: UILabel!
  @IBOutlet var statusBanner: UIImageView!
  
  var snowView: SnowView!
  
  //MARK: view controller methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //adjust ui
    summary.addSubview(summaryIcon)
    summaryIcon.center.y = summary.frame.size.height/2
    
    //add the snow effect layer
    snowView = SnowView(frame: CGRect(x: -150, y:-100, width: 300, height: 50))
    let snowClipView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 50))
    snowClipView.clipsToBounds = true
    snowClipView.addSubview(snowView)
    view.addSubview(snowClipView)
    
    //start rotating the flights
    changeFlight(to: londonToParis)
  }
  
  //MARK: custom methods
  
  func changeFlight(to data: FlightData, animated: Bool = false) {
    
    // populate the UI with the next flight's data
    if animated {
      planeDepart()
      summarySwitch(to: data.summary)

      fadeImageView(imageView: bgImageView,
                    toImage: UIImage(named: data.weatherImageName)!,
                    showEffects: data.showWeatherEffects)

      let direction: AnimationDirection = data.isTakingOff ?
        .positive : .negative

      cubeTransition(label: flightNr, text: data.flightNr,  direction: direction)
      cubeTransition(label: gateNr, text: data.gateNr,  direction: direction)

      let offsetDeparting = CGPoint(
        x: CGFloat(direction.rawValue * 80),
        y: 0.0
      )

      moveLabel(label: departingFrom, text: data.departingFrom,
                offset: offsetDeparting)

      let offsetArriving = CGPoint(
        x: 0.0,
        y: CGFloat(direction.rawValue * 50)
      )

      moveLabel(label: arrivingTo, text: data.arrivingTo,
                offset: offsetArriving)

      cubeTransition(label: flightStatus, text: data.flightStatus,  direction: direction)

    } else {
      bgImageView.image = UIImage(named: data.weatherImageName)
      snowView.isHidden = !data.showWeatherEffects
      flightNr.text = data.flightNr
      gateNr.text = data.gateNr
      departingFrom.text = data.departingFrom
      arrivingTo.text = data.arrivingTo

      flightStatus.text = data.flightStatus
      summary.text = data.summary
    }
    
    // schedule next flight
    delay(seconds: 3.0) {
      self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis, animated: true)
    }
  }

  func fadeImageView(imageView: UIImageView, toImage: UIImage, showEffects: Bool) {

    UIView.transition(with: imageView, duration: 1.0, options: .transitionCrossDissolve,
      animations: {
        imageView.image = toImage
      },
      completion: nil
    )

    UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut,
      animations: {
        self.snowView.alpha = showEffects ? 1.0 : 0.0
      },
      completion: nil
    )
  }

  func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) {

    let auxLabel = UILabel(frame: label.frame)
    auxLabel.text = text
    auxLabel.font = label.font
    auxLabel.textAlignment = label.textAlignment
    auxLabel.textColor = label.textColor
    auxLabel.backgroundColor = label.backgroundColor

    let auxLabelOffset = CGFloat(direction.rawValue) *
      label.frame.size.height/2.0

    auxLabel.transform = CGAffineTransform(scaleX: 1.0, y: 0.1).concatenating(
      CGAffineTransform(translationX: 0.0, y: auxLabelOffset))

    label.superview!.addSubview(auxLabel)

    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut,
      animations: {
        auxLabel.transform = .identity
        label.transform =
          CGAffineTransform(scaleX: 1.0, y: 0.1).concatenating(
          CGAffineTransform(translationX: 0.0, y: -auxLabelOffset))
      },
      completion: {_ in
        label.text = auxLabel.text
        label.transform = .identity

        auxLabel.removeFromSuperview()
      }
    )
  }

  func moveLabel(label: UILabel, text: String, offset: CGPoint) {
    let auxLabel = UILabel(frame: label.frame)
    auxLabel.text = text
    auxLabel.font = label.font
    auxLabel.textAlignment = label.textAlignment
    auxLabel.textColor = label.textColor
    auxLabel.backgroundColor = UIColor.clear

    auxLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
    auxLabel.alpha = 0
    view.addSubview(auxLabel)

    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn,
      animations: {
        label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        label.alpha = 0.0
      },
      completion: nil
    )

    UIView.animate(withDuration: 0.25, delay: 0.1, options: .curveEaseIn,
      animations: {
        auxLabel.transform = .identity
        auxLabel.alpha = 1.0
      },
      completion: {_ in
        //clean up
        auxLabel.removeFromSuperview()
        label.text = text
        label.alpha = 1.0
        label.transform = .identity
      }
    )
  }

  func planeDepart() {
    let originalCenter = planeImage.center

    UIView.animateKeyframes(withDuration: 1.5, delay: 0.0,
      animations: {
        //add keyframes
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25,
          animations: {
            self.planeImage.center.x += 80.0
            self.planeImage.center.y -= 10.0
          }
        )

        UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4) {
          self.planeImage.transform = CGAffineTransform(rotationAngle: -.pi / 8)
        }

        UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
          self.planeImage.center.x += 100.0
          self.planeImage.center.y -= 50.0
          self.planeImage.alpha = 0.0
        }

        UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
          self.planeImage.transform = .identity
          self.planeImage.center = CGPoint(x: 0.0, y: originalCenter.y)
        }

        UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45) {
          self.planeImage.alpha = 1.0
          self.planeImage.center = originalCenter
        }

      },
      completion: nil
    )
  }

  func summarySwitch(to summaryText: String) {

    UIView.animateKeyframes(withDuration: 1.0, delay: 0.0,
      animations: {
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.45) {
          self.summary.center.y -= 100.0
        }
        UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.45) {
          self.summary.center.y += 100.0
        }
      },
      completion: nil
    )

    delay(seconds: 0.5) {
      self.summary.text = summaryText
    }

  }

}
