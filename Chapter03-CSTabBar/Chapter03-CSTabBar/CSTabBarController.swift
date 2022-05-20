//
//  CSTabBarController.swift
//  Chapter03-CSTabBar
//
//  Created by mars on 2021/07/28.
//

import UIKit

class CSTabBarController: UITabBarController {

    let csView = UIView()
    let tabItem01 = UIButton(type: .system)
    let tabItem02 = UIButton(type: .system)
    let tabItem03 = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        
        let width = self.view.frame.width
        let height: CGFloat = 50
        let x: CGFloat = 0
        let y = self.view.frame.height - height
        
        self.csView.frame = CGRect(x: x, y: y, width: width, height: height)
        self.csView.backgroundColor = .brown
        self.view.addSubview(self.csView)
        
        let tabBtnWidth = self.csView.frame.size.width / 3
        let tabBtnHeight = self.csView.frame.height
        self.tabItem01.frame = CGRect(x: 0, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabItem02.frame = CGRect(x: tabBtnWidth, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabItem03.frame = CGRect(x: tabBtnWidth * 2, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        
        self.addTabBarBtn(btn: self.tabItem01, title: "첫 번째 버튼", tag: 0)
        self.addTabBarBtn(btn: self.tabItem02, title: "두 번째 버튼", tag: 1)
        self.addTabBarBtn(btn: self.tabItem03, title: "세 번째 버튼", tag: 2)
        
        self.onTabBarItemClick(self.tabItem01)

    }
    func addTabBarBtn(btn: UIButton, title: String, tag: Int) {
        btn.setTitle(title, for: .normal)
        btn.tag = tag
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitleColor(UIColor.yellow, for: .selected)
        btn.addTarget(self, action: #selector(onTabBarItemClick(_:)), for: .touchUpInside)
        self.csView.addSubview(btn)
    }
    // 모든 버튼을 선택되지 않은 상태로 만들어 준 후 사용자가 선택한 버튼의 상태만 다시 바꾸어 줌
    @objc func onTabBarItemClick(_ sender: UIButton) {
        self.tabItem01.isSelected = false
        self.tabItem02.isSelected = false
        self.tabItem03.isSelected = false
        
        sender.isSelected = true
        self.selectedIndex = sender.tag
    }
    
}
