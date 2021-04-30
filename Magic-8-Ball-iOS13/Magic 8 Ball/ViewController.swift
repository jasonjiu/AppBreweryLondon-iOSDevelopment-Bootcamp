//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Angela Yu on 14/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = #imageLiteral(resourceName: "ball5")
        
    }
    
    @IBAction func askBtnPressed(_ sender: UIButton) {
        let ballArray = [#imageLiteral(resourceName: "ball3"), #imageLiteral(resourceName: "ball3"), #imageLiteral(resourceName: "ball3"), #imageLiteral(resourceName: "ball1"), #imageLiteral(resourceName: "ball4")]
        imageView.image = ballArray.randomElement()
    }
    
}

