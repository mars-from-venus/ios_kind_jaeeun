//
//  FrontViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by mars on 2021/07/29.
//

import UIKit

class FrontViewController: UIViewController {
    
    var delegate: RevealViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide))
        self.navigationItem.leftBarButtonItem = btnSideBar
        
        // 화면 끝에서 드래그하는 동작을 인식
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide))
        dragLeft.edges = UIRectEdge.left
        self.view.addGestureRecognizer(dragLeft)
        
        // 중간 위치에서 드래그하는 동작을 인식
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide))
        dragRight.direction = .left
        self.view.addGestureRecognizer(dragRight)
    }
    @objc func moveSide(_ sender: Any) {
        if sender is UIScreenEdgePanGestureRecognizer {
            self.delegate?.openSideBar(nil)
        } else if sender is UISwipeActionsConfiguration {
            self.delegate?.closeSideBar(nil)
        } else if sender is UIBarButtonItem {
            if self.delegate?.isSideBarShowing == false {
                self.delegate?.openSideBar(nil)
            } else {
                self.delegate?.closeSideBar(nil)
            }
        }

}
}
