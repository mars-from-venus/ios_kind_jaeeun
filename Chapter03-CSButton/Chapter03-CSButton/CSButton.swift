//
//  CSButton.swift
//  Chapter03-CSButton
//
//  Created by mars on 2021/07/27.
//

import UIKit

public enum CSButtonType {
    case rect
    case circle
}

class CSBUtton: UIButton {
//init 구문은 스토리보드 방식으로 객체를 생설할 때 호출되는 초기화 메소드(규격화됨)
    //프로퍼티 옵저버
    
    
    var style: CSButtonType = .rect {
        didSet {
            switch style {
            case .rect:
                self.backgroundColor = .black
                self.layer.borderColor = UIColor.black.cgColor
                self.layer.borderWidth = 2
                self.layer.cornerRadius = 0
                self.setTitleColor(.white, for:.normal)
                self.setTitle("Rect Button", for:.normal)
            case .circle:
                self.backgroundColor = .red
                self.layer.borderColor = UIColor.blue.cgColor
                self.layer.borderWidth = 2
                self.layer.cornerRadius = 50
                self.setTitle("Circle Button", for:.normal)
                
            }
        }
    }
    required init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.backgroundColor = .green
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.setTitle("버튼", for: .normal)
    }
    // CGRect 타입의 인자값을 입력받는 초기화 메소드를 정의 => 프로그래밍 박식으로 버튼 객체를 생성할 때
    // 부모의 지정 초기화 메소드를 호출
    override init(frame: CGRect) {
        super.init(frame: frame)
    //커스터마이징
        self.backgroundColor = .gray
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.setTitle("코드로 생성된 버튼", for: .normal)
    }
    //매개변수가 없는 초기화 메소드
    init() {
        super.init(frame: CGRect.zero)
    }
    convenience init(type: CSButtonType){
        self.init()
        self.addTarget(self, action: #selector(counting(_:)), for: .touchUpInside)
        
        switch type {
        case .rect:
            self.backgroundColor = .black
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 0
            self.setTitleColor(.white, for:.normal)
            self.setTitle("Rect Button", for:.normal)
        case .circle:
            self.backgroundColor = .red
            self.layer.borderColor = UIColor.blue.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 50
            self.setTitle("Circle Button", for:.normal)
        }
    }
    
    @objc func counting(_ sender: UIButton) {
        sender.tag = sender.tag + 1
        sender.setTitle("\(sender.tag) 번째 클릭", for: .normal)
    }

}
// 모두 지정 초기화 메소드
