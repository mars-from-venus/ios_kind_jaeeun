//
//  ViewController.swift
//  Chapter03-Alert
//
//  Created by mars on 2021/07/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaultAlertBtn = UIButton(type: .system)
        defaultAlertBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        defaultAlertBtn.center.x = self.view.frame.width / 2
        defaultAlertBtn.setTitle("기본 알림창", for: .normal)
        defaultAlertBtn.addTarget(self, action: #selector(defaultAlert(_:)), for: .touchUpInside)
        self.view.addSubview(defaultAlertBtn)
    }
    @objc func defaultAlert(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let v = UIViewController()
        v.view.backgroundColor = .red
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.setValue(v, forKey: "contentViewController") // 값, 속성 이름 순서로 대입, 알림창에 뷰 컨트롤러를 등록함
        self.present(alert, animated: false)
    }

}

