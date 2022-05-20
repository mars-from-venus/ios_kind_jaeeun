//
//  ImageViewController.swift
//  Chapter03-Alert
//
//  Created by mars on 2021/07/27.
//

import UIKit

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let icon = UIImage(named: "rating5")
        let iconV = UIImageView(image: icon)
        
        iconV.frame = CGRect(x: 0, y: 0, width: (icon?.size.width)!, height: (icon?.size.width)!)
        self.view.addSubview(iconV)
        //외부 객체가 현재 뷰를 나타낼때 참고할 사이즈를 지정, CGSize 사용
        self.view = iconV
        self.preferredContentSize = CGSize(width: (icon?.size.width)!, height: (icon?.size.height)! + 10)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
