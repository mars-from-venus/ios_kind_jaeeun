//
//  ViewController.swift
//  Chapter03-CSButton
//
//  Created by mars on 2021/07/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       let csBtn = CSBUtton()
        csBtn.frame = CGRect(x: 30, y: 50, width: 150, height: 30)
        self.view.addSubview(csBtn)
        
        let rectBtn = CSBUtton(type: .rect)
        rectBtn.frame = CGRect(x: 30, y: 200, width: 150, height: 30)
        self.view.addSubview(rectBtn)
        
        let circleBtn = CSBUtton(type: .circle)
        circleBtn.frame = CGRect(x: 200, y: 200, width: 150, height: 30)
        self.view.addSubview(circleBtn)
        
    }


}

