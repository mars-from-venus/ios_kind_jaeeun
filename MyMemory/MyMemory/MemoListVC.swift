//
//  MemoListVCTableViewController.swift
//  MyMemory
//
//  Created by mars on 2021/07/17.
//

import UIKit

class MemoListVC: UITableViewController, UISearchBarDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var dao = MemoDAO()
    @IBOutlet var searchBar : UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.enablesReturnKeyAutomatically = false
        if let revealVC = self.revealViewController() {
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu.png")
            btn.target = revealVC
            btn.action = #selector(revealVC.revealToggle(_:))
            self.navigationItem.leftBarButtonItem = btn
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keyword = searchBar.text // 검색 바에 입력된 키워드를 가져온다.
        // 키워드를 적용하여 데이터를 검색하고, 테이블 뷰를 갱신한다.
        self.appDelegate.memolist = self.dao.fetch(keyword: keyword)
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // MARK: - Table view data source

    //특정 섹션이 몇 개의 행으로 이루워지는가를 결정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = self.appDelegate.memolist.count
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1.memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼낸다.
        let row = self.appDelegate.memolist[indexPath.row]
        //2.이미지 속성이 비어 있을 경우 "memoCell", 아니면 "memoCellWithImage"
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        //3.재사용 큐로부터 프로포타입 셀의 인스턴스를 전달받는다.
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        //4.memoCell의 내용을 구성한다
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image
        //5.Data 타입의 날짜를 yyyy-MM-dd HH:mm:ss 포맷에 맞게 변경한다.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = formatter.string(from: row.regdate!)
        //6.cell 객체를 리턴한다.
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        let ud = UserDefaults.standard
        if ud.bool(forKey: UserInfoKey.tutorial) == false {
            let vc = self.instanceTutorial(name: "MasterVC")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: false)
            return
        }
        // 코어 데이터에 저장된 데이터를 가져온다.
        self.appDelegate.memolist = self.dao.fetch()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.appDelegate.memolist[indexPath.row]
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
            return
        }
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // 삭제 기능 구현
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let data = self.appDelegate.memolist[indexPath.row]
        // 코어 데이터에서 삭제한 다음, 배열 내 데이터 및 테이블 뷰행을 차례로 삭제한다.
        if dao.delete(data.objectID!) {
            self.appDelegate.memolist.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
