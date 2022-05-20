//
//  SideBarViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by mars on 2021/07/29.
//

import UIKit

class SideBarViewController: UITableViewController {

    let titles = ["메뉴 01", "메뉴 02", "메뉴 03", "메뉴 04", "메뉴 05"]
    let icons = [UIImage(named: "icon01.png"), UIImage(named: "icon02.png"), UIImage(named: "icon03.png"), UIImage(named: "icon04.png"),UIImage(named: "icon05.png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
        accountLabel.text = "sqlpro@naver.com"
        accountLabel.textColor = .white
        accountLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        v.backgroundColor = .brown
        v.addSubview(accountLabel)
        self.tableView.tableHeaderView = v
    }
    // 테이블 뷰의 상단과 하단에는 각각 헤더, 푸터라고 불리는 공간이 있음(뷰로 이루어짐)
    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "menucell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id) // 스토리보드의 도움없이 재사용 큐를 사용하기 위해 사용
 
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        // Configure the cell...

        return cell
    }


  

}
