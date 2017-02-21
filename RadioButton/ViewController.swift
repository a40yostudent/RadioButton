//  ----------------------------------------------------------------------------
//
//  ViewController.swift
//
//  ----------------------------------------------------------------------------

import UIKit

class ViewController: UIViewController, RadioButtonsViewDelegate {
  
  @IBOutlet weak var radioButtonsView: RadioButtonsView!
  
  @IBOutlet weak var testLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    radioButtonsView.delegate = self
  }
  
  func didSelectButton(_ aButton: RoundButton?) {
    testLabel.text = radioButtonsView.currentSelectedButton?.titleLabel?.text
  }

}
