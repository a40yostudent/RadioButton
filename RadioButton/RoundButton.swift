/*
  ------------------------------------------------------------------------------

  MIT License

  Copyright (c) 2017 Sabino Paulicelli

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

  ------------------------------------------------------------------------------

  RoundButton.swift

  ------------------------------------------------------------------------------
*/

import UIKit

final class RoundButton: UIButton {
  
  var borderWidth: CGFloat = 2.0
  var primaryColor: UIColor = UIColor.blue
  
  var primaryColorWithAlpha: UIColor {
    return primaryColor.withAlphaComponent(0.25)
  }
  
  override public var buttonType: UIButtonType {
    return .custom
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = bounds.size.width * 0.5
    self.clipsToBounds = true
    setupColors()
  }

  func setupColors() {
    switch self.state {
    case UIControlState.normal:
      super.backgroundColor = .white
      self.setTitleColor(primaryColor, for: state)
      self.layer.borderColor = primaryColor.cgColor
      self.layer.borderWidth = borderWidth
    default:
      super.backgroundColor = primaryColorWithAlpha
      self.setTitleColor(.white, for: state)
    }
  }
  
}
