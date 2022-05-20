//
//  RevealViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by mars on 2021/07/29.
//

import UIKit

class RevealViewController: UIViewController {
    var contentVC: UIViewController? // 콘텐츠를 담당할 뷰 컨트롤러
    var sideVC: UIViewController? // 사이드 바 메뉴를 담당할 뷰 컨트롤러
    var isSideBarShowing = false // 현재 사이드 바가 열려 있는지 여부
    let SLIDE_TIME = 0.3 // 사이드 바가 열리고 닫히는 데 걸리는 시간
    let SIDEBAR_WIDTH:CGFloat = 260 // 사이드 바가 열릴 너비

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setShadowEffect(shadow: true, offset: 0.7)

    }
    func setupView() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController {
            self.contentVC = vc
            self.addChild(vc)
            self.view.addSubview(vc.view) // 뷰의 계층과 뷰 컨트롤러의 계층은 서로 분리되있기때문에 뷰도 자식으로 등록
            vc.didMove(toParent: self)
            // viewController는 내비게이션 컨트롤에 연결된 자식 컨트롤러들의 참조 정보가 저장되는 배열, 먼저 연결된 순서대로 저장
            let frontVC = vc.viewControllers[0] as? FrontViewController
            frontVC?.delegate = self
        }
    }
    func getSideView() {
        // 사이드 바가 열릴 때에만 잠깐 컨트롤러 인스턴스를 생성했다가 닫히면 인스턴스를 제거하기 때문에 값이 비어있을 수 있음
        guard self.sideVC == nil else {
            return
        }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear") else {
            return
        }
        self.sideVC = vc
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        self.view.bringSubviewToFront((self.contentVC?.view)!) // 콘텐츠뷰를 사이드 바보다 앞으로 보내기 위해 (등록순서에 상관없이)
    }
    func setShadowEffect(shadow: Bool, offset: CGFloat) {
        if (shadow == true) {
            self.contentVC?.view.layer.masksToBounds = false
            self.contentVC?.view.layer.cornerRadius = 10
            self.contentVC?.view.layer.shadowOpacity = 0.8
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset)
        } else {
            self.contentVC?.view.layer.cornerRadius = 0.0
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    func openSideBar(_ complete: (()->Void)?) {
        self.getSideView()
        self.setShadowEffect(shadow: true, offset: -2)
        // 여러 개의 옵션을 중첩해서 적용할 수 있도록 배열로 입력받음, 1번째: 애니메이션 구간별 속도옵션 2번째:현재 다른애니가 진행되도 지금바로 진행하란의미
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        // animations : 실행할 내용
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options, animations: {self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)}, completion: {
            if $0 == true {
                self.isSideBarShowing = true
                complete?()
            }
        }
    )
}
    func closeSideBar(_ complete: (()->Void)?){
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        UIView.animate(withDuration: TimeInterval(SLIDE_TIME), delay: TimeInterval(0), options: options, animations: {self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)}, completion: {
            if $0 == true {
                self.sideVC?.view.removeFromSuperview()
                self.sideVC = nil
                self.isSideBarShowing = false
                self.setShadowEffect(shadow: false, offset: 0)
                complete?()
            }
        })
    }
}
