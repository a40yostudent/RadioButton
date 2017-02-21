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

  RadioButtonsView.swift

  ------------------------------------------------------------------------------
*/

import UIKit

@objc protocol RadioButtonsViewDelegate {
  @objc optional func didSelectButton(_ aButton: RoundButton?)
}

@IBDesignable
class RadioButtonsView: UIStackView {
  
  var shouldLetDeselect = true
  
  var buttons = [RoundButton]()
  
  weak var delegate : RadioButtonsViewDelegate? = nil
  
  private(set) weak var currentSelectedButton: RoundButton? = nil
  
  @IBInspectable
  var number: Int = 2 {
    didSet {
      number = max(number, 2)
      setupButtons()
    }
  }
  
  func setupButtons() {
    if !buttons.isEmpty {
      buttons.forEach { self.removeArrangedSubview($0) }
      buttons.removeAll()
    }
    
    for i in 0..<self.number {
      let button = RoundButton()
      button.setTitle("\(i)", for: .normal)
      button.addTarget(self, action: #selector(pressed(_:)),
                       for: UIControlEvents.touchUpInside)
      buttons.append(button)
    }
  }
  
  func pressed(_ sender: RoundButton) {
    if (sender.isSelected) {
      if shouldLetDeselect {
        sender.isSelected = false
        currentSelectedButton = nil
      }
    }else {
      buttons.forEach { $0.isSelected = false }
      sender.isSelected = true
      currentSelectedButton = sender
    }
    delegate?.didSelectButton?(currentSelectedButton)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButtons()
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
    setupButtons()
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: self.bounds.width,
                  height: UIViewNoIntrinsicMetric)
  }
  
  override func layoutSubviews() {
    self.translatesAutoresizingMaskIntoConstraints = false

    buttons.forEach { self.addArrangedSubview($0) }
    
    let constraints: [NSLayoutConstraint] = {
      var constraints = [NSLayoutConstraint]()
      constraints.append(NSLayoutConstraint(item: buttons[0],
                                                 attribute: NSLayoutAttribute.width,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: self,
                                                 attribute: NSLayoutAttribute.height,
                                                 multiplier: 1,
                                                 constant: 0)
        )
      for i in 1..<buttons.count {
        constraints.append(NSLayoutConstraint(item: buttons[i],
                                            attribute: NSLayoutAttribute.width,
                                            relatedBy: NSLayoutRelation.equal,
                                            toItem: buttons[i - 1],
                                            attribute: NSLayoutAttribute.width,
                                            multiplier: 1,
                                            constant: 0)
        )
      }
      return constraints
    }()
    
    self.addConstraints(constraints)
  }
  
}
