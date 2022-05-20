//
//  NewSceneDelegate.swift
//  Chapter03-TabBar
//
//  Created by mars on 2021/07/23.
//

import UIKit

class NewSceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo Session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let tbC = UITabBarController()
        tbC.view.backgroundColor = .white
        self.window?.rootViewController = tbC
        
        let view01 = ViewController()
        let view02 = SecondViewController()
        let view03 = ThirdViewController()
        
        tbC.setViewControllers([view01, view02, view03], animated: false) // 탭 바 컨트롤러에 뷰컨트롤러를 등록
        view01.tabBarItem = UITabBarItem(title: "calendar", image: UIImage(named: "calendar"), selectedImage: nil)
        view02.tabBarItem = UITabBarItem(title: "file", image: UIImage(named: "file-tree"), selectedImage: nil)
        view03.tabBarItem = UITabBarItem(title: "photo", image: UIImage(named: "photo"), selectedImage: nil)
    }
    
}
