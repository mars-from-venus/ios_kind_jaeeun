//
//  ViewController.swift
//  Chapter03-NavigationBar
//
//  Created by mars on 2021/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initTitleInput()
    }

    func initTilte() {
        let nTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        nTitle.numberOfLines = 2
        nTitle.textAlignment = .center
        nTitle.textColor = .white
        nTitle.font = UIFont.systemFont(ofSize: 15)
        nTitle.text = "58개 숙소 \n 1박(1월 10일 ~ 1월 11일)" // \n <= 줄바꿈 문자
        self.navigationItem.titleView = nTitle
        
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
    }
    func initNewTitle() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
        let topTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 18))
        topTitle.numberOfLines = 1
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 15)
        topTitle.textColor = .white
        topTitle.text = "58개 숙소"
        
        let subTitle = UILabel(frame: CGRect(x: 0, y: 18, width: 200, height: 18))
        subTitle.numberOfLines = 1
        subTitle.textAlignment = .center
        subTitle.font = UIFont.systemFont(ofSize: 12)
        subTitle.textColor = .white
        subTitle.text = "1박(1월 10일 ~ 1월 11일)"
        
        containerView.addSubview(topTitle)
        containerView.addSubview(subTitle)
        
        self.navigationItem.titleView = containerView
        
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
    }
    func initImageTitle() {
        let imageTitle = UIImage(named: "swift_logo")
        let imT = UIImageView(image: imageTitle)
        self.navigationItem.titleView = imT
    }
    func initTitleInput() {
        let tp = UITextField()
        tp.frame = CGRect(x: 0, y: 0, width: 300, height: 35)
        tp.backgroundColor = .white
        tp.font = UIFont.systemFont(ofSize: 13)
        tp.autocapitalizationType = .none
        tp.autocorrectionType = .no
        tp.spellCheckingType = .no
        tp.keyboardType = .URL
        tp.keyboardAppearance = .dark
        tp.layer.borderWidth = 0.3
        tp.layer.borderColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0).cgColor
        self.navigationItem.titleView = tp
        
       /* let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: 150, height: 37)
        v.backgroundColor = .brown
        let leftItem = UIBarButtonItem(customView: v)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rv = UIView()
        rv.frame = CGRect(x: 0, y: 0, width: 100, height: 37)
        rv.backgroundColor = .red
        let rightItem = UIBarButtonItem(customView: rv)
        self.navigationItem.rightBarButtonItem = rightItem
         */
        let back = UIImage(named: "arrow-back")
        let leftItem = UIBarButtonItem(image: back, style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let containner = UIView()
        containner.frame = CGRect(x: 0, y: 0, width: 70, height: 37)
        let rightItem = UIBarButtonItem(customView: containner) // 아이템 영역에 커스텀뷰를 대입하여 다양한 기능을 넣음
        self.navigationItem.rightBarButtonItem = rightItem
        
        let cnt = UILabel()
        cnt.frame = CGRect(x: 10, y: 8, width: 20, height: 20)
        cnt.font = UIFont.boldSystemFont(ofSize: 10)
        cnt.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0)
        cnt.text = "12"
        cnt.textAlignment = .center
        cnt.layer.cornerRadius = 3
        cnt.layer.borderWidth = 2
        cnt.layer.borderColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0).cgColor
        containner.addSubview(cnt)
        
        let more = UIButton(type: .system)
        more.frame = CGRect(x: 50, y: 10, width: 16, height: 16)
        more.setImage(UIImage(named: "more"), for: .normal)
        containner.addSubview(more)
        
    }

}

