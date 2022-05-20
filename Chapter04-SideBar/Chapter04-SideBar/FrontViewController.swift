//
//  FrontViewController.swift
//  Chapter04-SideBar
//
//  Created by mars on 2021/07/29.
//

import UIKit
class FrontViewController: UIViewController {
    @IBOutlet weak var sideBarButton: UIBarButtonItem!
    //SWRevealViewController를 라이브러리에서 가져옴
    override func viewDidLoad() {
        super.viewDidLoad()
        if let revealVC = self.revealViewController() {
            self.sideBarButton.target = revealVC
            self.sideBarButton.action = #selector(revealVC.revealToggle(_:))
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
    }

}

