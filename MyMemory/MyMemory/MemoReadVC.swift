//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by mars on 2021/07/17.
//

import UIKit

class MemoReadVC: UIViewController {
    var param: MemoData?
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents2: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subject.text = param?.title
        self.contents2.text = param?.contents
        self.img.image = param?.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        self.navigationItem.title = dateString
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
