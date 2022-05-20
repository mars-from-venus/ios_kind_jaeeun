//
//  ViewController.swift
//  Chapter03-TabBar
//
//  Created by mars on 2021/07/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        title.text = "첫번째 탭"
        title.textColor = .red
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.sizeToFit() // 콘텐츠 내용에 맞추어 레이블 크기를 조절 -> 엘립시스 처리 ex) 스토리보드에서 command + (=)
        title.center.x = self.view.frame.width / 2 // 레이블의 center.x 속성을 화면 중앙으로 설정
        self.view.addSubview(title)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = self.tabBarController?.tabBar
        tabBar?.isHidden = (tabBar?.isHidden == true) ? false : true
        UIView.animate(withDuration: TimeInterval(0.3)){
            tabBar?.alpha = ( tabBar?.alpha == 0 ? 1 : 0 )
        } // animation: 실행될 애니메이션의 내용을 정의
        // func exec() { tabBar?.alpha = ( tabBar?.alpha == 0 ? 1 : 0 ) } => 트레일링 클로져로 간단하게 사용
    } // 토글 방식

}

/*
 트레일링 클로저 과정
 1.원래의 함수
 func exec() {
    tabBar?.alpha = ( tabBar?.alpha == 0 ? 1 : 0 )
 }
 
 2. exec 함수를 클로저로 변경하여 인자값으로 사용
 UIView.animate(withDuration: TimeInterval(0.15), animations: {
    tabBar?.alpha = ( tabBar?.alpha  == 0 ? 1 : 0)
 })
 
 3. 클로저 블록을 떼어 내고, 마지막 매개변수를 생략한뒤 클로저 블록을 맨 뒤에 붙임
 UIView.animate(withDuration: TimeInterval(0.15)){
     tabBar?.alpha = ( tabBar?.alpha == 0 ? 1 : 0 )
 }
 */
