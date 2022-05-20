//
//  CSStepper.swift
//  Chapter03-CSSteper
//
//  Created by mars on 2021/07/28.
//

import UIKit
@IBDesignable
public class CSStepper: UIControl {
    
    public var leftBtn = UIButton(type: .system)
    public var rightBtn = UIButton(type: .system)
    public var centerLabel = UILabel()
    
    @IBInspectable // 우리가 정의한 속성을 인터페이스 빌더에서도 설정할 수 있도록 처리해주는 어트리뷰트
    public var value : Int = 0 {
        didSet {
            self.centerLabel.text = String(value) //변경된 value
            self.sendActions(for: .valueChanged)
        }
    }
    @IBInspectable
    public var leftTitle: String = "↓" {
        didSet {
            self.leftBtn.setTitle(leftTitle, for: .normal)
        }
    }
    @IBInspectable
    public var rightTitle: String = "↑" {
        didSet {
            self.rightBtn.setTitle(rightTitle, for: .normal)
        }
    }
    @IBInspectable
    public var bgColor: UIColor = UIColor.cyan {
        didSet {
            self.centerLabel.backgroundColor = backgroundColor
        }
    }
    @IBInspectable
    public var stepValue: Int = 1
    @IBInspectable public var maximumValue: Int = 100
    @IBInspectable public var minimumValue: Int = -100
    
    /*let stepper = CSStepper()
    stepper.leftBtn.setTitle("-", for: .normal)
    stepper.rightBtn.setTitle("+", for: .normal)
    stepper.centerLabel.text = "0000"*/
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup() {
        
        let borderWidth: CGFloat = 0.5
        let borderColor = UIColor.blue.cgColor
        
        self.leftBtn.tag = -1
        self.leftBtn.setTitle(self.leftTitle, for: .normal) // 특수기호 ctrl + command + space
        self.leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.leftBtn.layer.borderWidth = borderWidth
        self.leftBtn.layer.borderColor = borderColor
        
        self.rightBtn.tag = 1
        self.rightBtn.setTitle(self.rightTitle, for: .normal)
        self.rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.rightBtn.layer.borderWidth = borderWidth
        self.rightBtn.layer.borderColor = borderColor
        
        self.centerLabel.text = String(value)
        self.centerLabel.font = UIFont.systemFont(ofSize: 16)
        self.centerLabel.textAlignment = .center
        self.centerLabel.backgroundColor = self.bgColor
        self.centerLabel.layer.borderWidth = borderWidth
        self.centerLabel.layer.borderColor = borderColor
        
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
        self.addSubview(self.centerLabel)
        
        self.leftBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
        self.rightBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
        
    }
    
    override public func layoutSubviews() {
        let btnWidth = self.frame.height
        let lblWidth = self.frame.width - (btnWidth * 2)
        self.leftBtn.frame = CGRect(x: 0, y: 0, width: btnWidth, height: btnWidth)
        self.rightBtn.frame = CGRect(x: btnWidth + lblWidth, y: 0, width: btnWidth, height: btnWidth)
        self.centerLabel.frame = CGRect(x: btnWidth, y: 0, width: lblWidth, height: btnWidth)
    }
    
    @objc public func valueChange(_ sender: UIButton) {
        self.value += sender.tag

        let sum = self.value + (sender.tag * self.stepValue)
        if sum > self.maximumValue {
            return
        }
        if sum < self.minimumValue {
            return
        }
        self.value += (sender.tag * self.stepValue)
    }
    
}
