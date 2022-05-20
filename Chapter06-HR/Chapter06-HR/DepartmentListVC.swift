//
//  DepartmentListVC.swift
//  Chapter06-HR
//
//  Created by mars on 2021/08/07.
//

import UIKit

class DepartmentListVC: UITableViewController {
    

    // 데이터 소스용 멤버 변수
    var departList: [(departCd: Int, departTitle: String, departAddr: String)]!
    let departDAO = DepartmentDAO()
    
    func initUI() {
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "부서 목록 \n" + " 총 \(self.departList.count) 개"
        
        self.navigationItem.titleView = navTitle
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // 해당 셀만 편집 모드로 전환되도록 설정
        self.tableView.allowsSelectionDuringEditing = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.departList = self.departDAO.find() // 기존 저장된 부서 정보를 가져온다
        self.initUI()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.departList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indexPath 매개변수가 가리키는 행에 대한 데이터를 읽어온다.
        let rowData = self.departList[indexPath.row]
        // 셀 객체를 생성하고 데이터를 배치한다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEPART_CELL")
        cell?.textLabel?.text = rowData.departTitle
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.detailTextLabel?.text = rowData.departAddr
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "신규 부서 등록", message: "신규 부서를 등록해 주세요", preferredStyle: .alert)
        alert.addTextField() { (tf) in tf.placeholder = "부서명"}
        alert.addTextField() { (tf) in tf.placeholder = "주소"}
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
            let title = alert.textFields?[0].text // 부서명
            let addr = alert.textFields?[1].text // 주소
            
            //신규 부서가 등록되면 DB에서 목록을 다시 읽어온 후 , 테이블을 갱신함
            if self.departDAO.create(title: title!, addr: addr!) {
                self.departList = self.departDAO.find()
                self.tableView.reloadData()
                
                let navTitle = self.navigationItem.titleView as! UILabel
                navTitle.text = "부서 목록 \n" + " 총 \(self.departList.count) 개"
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1. 삭제할 행의 departCd를 구한다.
        let departCd = self.departList[indexPath.row].departCd
        
        // 2. DB에서, 데이터 소스에서, 그리고 테이블 뷰에서 차례대로 삭제한다.
        if departDAO.remove(departCd: departCd) {
            self.departList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 화면 이동 시 함께 전달할 부서 코드
        let departCd = self.departList[indexPath.row].departCd
        // 이동할 대상 뷰 컨트롤러의 인스턴스
        let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "DEPART_INFO")
        if let _infoVC = infoVC as? DepartmentInfoVC {
            // 부서 코드를 전달할 다음, 푸시 방식으로 화면 이동
            _infoVC.departCd = departCd
            self.navigationController?.pushViewController(_infoVC, animated: true)
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
