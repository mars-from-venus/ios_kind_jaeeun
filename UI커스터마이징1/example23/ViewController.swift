//
//  ViewController.swift
//  example23
//
//  Created by mars on 2021/07/22.
//

import UIKit

class ViewController: UIViewController {

    var paramEmail: UITextField! // 이메일 입력필드
    var paramUpdate: UISwitch! // 스위치 객체
    var paramInterval: UIStepper! // 스테퍼 객체
    var txtUpdate: UILabel! // 스위치 컨트롤 값을 표현할 레이블
    var txtInterval: UILabel! // 스테퍼 컨트롤 값을 표현할 레이블
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "설정" // 네비게이션바 타이틀 입력
        let IbIEmail = UILabel()
        IbIEmail.frame = CGRect(x: 30, y: 100, width: 100, height: 30)
        IbIEmail.text = "이메일"
        IbIEmail.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(IbIEmail)
        
        let IbIInterval = UILabel()
        IbIInterval.frame = CGRect(x: 30, y: 200, width: 100, height: 30)
        IbIInterval.text = "갱신주기"
        IbIInterval.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(IbIInterval)
        
        let IbIUpdate = UILabel()
        IbIUpdate.frame = CGRect(x: 30, y: 150, width: 100, height: 30)
        IbIUpdate.text = "자동갱신"
        IbIUpdate.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(IbIUpdate)
        
        self.paramEmail = UITextField()
        self.paramEmail.frame = CGRect(x: 120, y: 100, width: 220, height: 30)
        self.paramEmail.font = UIFont.systemFont(ofSize: 13)
        paramEmail.textAlignment = NSTextAlignment.right
        paramEmail.adjustsFontSizeToFitWidth = true
        paramEmail.placeholder = "이메일 예) abc@naver.com"
        self.paramEmail.borderStyle = .roundedRect
        self.paramEmail.autocapitalizationType = .none
        self.view.addSubview(self.paramEmail)
        
        self.paramUpdate = UISwitch()
        self.paramUpdate.frame = CGRect(x: 120, y: 150, width: 50, height: 30)
        self.paramUpdate.setOn(true, animated: true)
        self.view.addSubview(self.paramUpdate)
        
        self.paramInterval = UIStepper()
        self.paramInterval.frame = CGRect(x: 120, y: 200, width: 50, height: 30)
        self.paramInterval.minimumValue = 0 // 스태퍼가 가질 수 있는 최소값
        self.paramInterval.maximumValue = 100 // 스태퍼가 가질 수 있는 최대값
        self.paramInterval.stepValue = 1 // 스태퍼 값 변경 단위
        self.paramInterval.value = 0 // 초기값 설정
        self.view.addSubview(self.paramInterval)
        
        self.txtUpdate = UILabel()
        self.txtUpdate.frame = CGRect(x: 250, y: 150, width: 100, height: 30)
        self.txtUpdate.font = UIFont.systemFont(ofSize: 12)
        self.txtUpdate.textColor = UIColor.red
        self.txtUpdate.text = "갱신함"
        self.view.addSubview(self.txtUpdate)
        
        self.txtInterval = UILabel()
        self.txtInterval.frame = CGRect(x: 250, y: 200, width: 100, height: 30)
        self.txtInterval.font = UIFont.systemFont(ofSize: 12)
        self.txtInterval.textColor = UIColor.red
        self.txtInterval.text = "0분마다"
        self.view.addSubview(self.txtInterval)
        
        self.paramUpdate.addTarget(self, action: #selector(presentUpdateValue(_:)), for: .valueChanged)
        self.paramInterval.addTarget(self, action: #selector(presentIntervalValue(_:)), for: .valueChanged)
        
        let submitBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(submit(_:)))
        self.navigationItem.rightBarButtonItem = submitBtn
    }
    @objc func presentUpdateValue(_ sender: UISwitch) {
        self.txtUpdate.text = (sender .isOn == true ? "갱신함" : "갱신하지 않음")
    } // 스위치와 상호반응할 액션 메소드
    @objc func presentIntervalValue(_ sender: UIStepper) {
        self.txtInterval.text = ("\( Int(sender.value) )분마다")
    } // 스테퍼와 상호반응할 액션 메소드
    @objc func submit(_ sender: Any) {
        let rvc = ReadViewController()
        rvc.pEmail = self.paramEmail.text
        rvc.pUpdate = self.paramUpdate.isOn
        rvc.pInterval = self.paramInterval.value
        self.navigationController?.pushViewController(rvc, animated: true)
    } // 전송 버튼과 상호반을할 액션 메소드
}

