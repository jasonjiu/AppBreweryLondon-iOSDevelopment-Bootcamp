//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var calculatorCore = CalculatorCore()
    

    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var weightValueLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSlider(_ sender: UISlider) {
        let value = String(format: "%.2f", sender.value)
        heightValueLabel.text = "\(value)m"
    }
    
    @IBAction func weightSlider(_ sender: UISlider) {
        let value = String(format: "%.0f", sender.value)
        weightValueLabel.text = "\(value)Kg"
    }
    
    @IBAction func calculateBtnPressed(_ sender: UIButton) {
        let heightValue = heightSlider.value
        let weightValue = weightSlider.value
        
        calculatorCore.calculateBMI(h: heightValue, w: weightValue)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorCore.getBMIValue()
            destinationVC.advice = calculatorCore.getAdvice()
            destinationVC.color = calculatorCore.getColor()
        }
    }
}

