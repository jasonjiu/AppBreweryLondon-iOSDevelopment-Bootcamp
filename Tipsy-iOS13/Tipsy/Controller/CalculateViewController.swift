//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroTipBtn: UIButton!
    @IBOutlet weak var tenTipBtn: UIButton!
    @IBOutlet weak var twentyTipBtn: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var splitBill = SplitBillCore()
    
    @IBAction func tipChangedPressed(_ sender: UIButton) {
        billTextField.endEditing(true)
        tenTipBtn.isSelected = false
        zeroTipBtn.isSelected = false
        twentyTipBtn.isSelected = false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleRemovePercent = String(buttonTitle.dropLast())
        splitBill.setTips(t: Double(buttonTitleRemovePercent) ?? 0.0)
    }
    
    @IBAction func calculateBtnPressed(_ sender: UIButton) {
        splitBill.calculateTotal(b: billTextField.text!)
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        splitBill.setNumberOfPeople(p: Int(sender.value))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.result = splitBill.getTotalBill()
            destinationVC.tip = Int(splitBill.getTips())
            destinationVC.split = splitBill.getNumberOfPeople()
        }
    }
}

