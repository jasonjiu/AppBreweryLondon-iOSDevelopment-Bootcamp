//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueBtn: UIButton!
    @IBOutlet weak var falseBtn: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var timer = Timer()
    var quizCore = QuizCore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    @IBAction func answerBtnPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        
        let userGotRight = quizCore.checkAnswer(userAnswer)
        
        if userGotRight {
            sender.backgroundColor = UIColor.green
            print("Right")
        }else{
            sender.backgroundColor = UIColor.red
            print("Wrong")
        }
        
        quizCore.nextQuestion()
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target:self, selector: #selector(updateUI), userInfo:nil, repeats: false)
        
    }
    
    @objc func updateUI(){
        questionLabel.text = quizCore.getQuestion()
        progressBar.progress = quizCore.getProgress()
        scoreLabel.text = "Score: \(quizCore.getScore())"
        trueBtn.backgroundColor = UIColor.clear
        falseBtn.backgroundColor = UIColor.clear
    }
}

