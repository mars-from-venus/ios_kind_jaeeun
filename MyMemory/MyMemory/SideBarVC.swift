//
//  SideBarVC.swift
//  MyMemory
//
//  Created by mars on 2021/07/29.
//

import UIKit

class SideBarVC: UITableViewController {
    
    let uinfo = UserInfoManager()
    let titles = ["새글 작성하기", "친구 새글", "달력으로 보기", "공지사항", "통계", "계정 관리"]
    let icons = [UIImage(named: "icon01.png"),UIImage(named: "icon02.png"),UIImage(named: "icon03.png"),UIImage(named: "icon04.png"),UIImage(named: "icon05.png"),UIImage(named: "icon06.png")]
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = .brown
        self.tableView.tableHeaderView = headerView
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        self.nameLabel.textColor = .white
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.emailLabel.backgroundColor = .clear
        headerView.addSubview(self.nameLabel)
        
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 100, height: 30)
        self.emailLabel.textColor = .white
        self.emailLabel.font = UIFont.boldSystemFont(ofSize: 11)
        self.emailLabel.backgroundColor = .clear
        headerView.addSubview(self.emailLabel)
        
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        // 반원 형태로 라운딩
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.width / 2)
        self.profileImage.layer.borderWidth = 0
        // 마스크 기능 - 기존의 이미지 위에 덧씌워서 일부를 가리는 역할
        self.profileImage.layer.masksToBounds = true
        view.addSubview(self.profileImage)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = self.uinfo.name ?? "Guest"
        self.emailLabel.text = self.uinfo.account ?? ""
        self.profileImage.image = self.uinfo.profile
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "menucell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            target.pushViewController(uv!, animated: true)
            self.revealViewController()?.revealToggle(self)
        } else if indexPath.row == 5 {
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "_Profile")
            uv?.modalPresentationStyle = .fullScreen // 레이어링 디자인 때문에
            self.present(uv!, animated: true) {
                self.revealViewController()?.revealToggle(self)
            } // 사이드 바는 닫기
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
