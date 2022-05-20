//
//  ViewController.swift
//  Chapter03-CSSteper
//
//  Created by mars on 2021/07/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let stepper = CSStepper()
        stepper.frame = CGRect(x: 30, y: 100, width: 130, height: 30)
        
        stepper.addTarget(self, action: #selector(logging(_:)), for: .valueChanged)
        self.view.addSubview(stepper)
    }
    @objc func logging(_ sender: CSStepper){
        NSLog("현재 스테퍼의 값은 \(sender.value)입니다")
    }

}

