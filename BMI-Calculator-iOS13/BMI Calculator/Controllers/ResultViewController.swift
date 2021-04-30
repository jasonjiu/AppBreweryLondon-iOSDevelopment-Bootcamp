//
//  SecondViewController.swift
//  BMI Calculator
//
//  Created by Jason Prosia on 26/04/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var bmiValueLabel: UILabel!
    @IBOutlet var viewBackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiValueLabel.text = bmiValue
        adviceLabel.text = advice
        viewBackground.backgroundColor = color
    }
    
    @IBAction func recaculateBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
