//
//  CalculatorCore.swift
//  BMI Calculator
//
//  Created by Jason Prosia on 26/04/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorCore {
    var bmi: BMI?
    
    mutating func calculateBMI(h:Float, w:Float){
        let bmiValue = w/(h * h)
        
        print(bmiValue)
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat More Please", color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        }else if bmiValue < 24.9{
            bmi = BMI(value: bmiValue, advice: "Fit as should be", color: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))
        }else {
            bmi = BMI(value: bmiValue, advice: "Diet please!", color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        }
    }
    
    func getBMIValue() -> String {
        
        let bmiToDecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiToDecimalPlace
    }
    
    func getColor() -> UIColor{
        return bmi?.color ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func getAdvice() -> String{
        return bmi?.advice ?? "No advice"

    }
    
}
