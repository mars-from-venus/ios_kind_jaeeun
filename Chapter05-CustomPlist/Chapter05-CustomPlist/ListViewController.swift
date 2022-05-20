//
//  ListViewController.swift
//  Chapter05-CustomPlist
//
//  Created by mars on 2021/08/02.
//

import UIKit

class ListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    @IBOutlet weak var account: UITextField!
    
    var accountlist = [String]()
    var defaultPList : NSDictionary!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountlist.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.accountlist[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let account = self.accountlist[row]
        self.account.text = account
        let plist = UserDefaults.standard
        plist.set(account, forKey: "selectedAccount")
        plist.synchronize()
    }
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex
        let customPlist = "\(self.account.text!).plist"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        // self.defaultPlist 는 NSDictionary 타입이기 때문에 수정이 불가능한 타입
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)
        data.setValue(value, forKey: "gender")
        data.write(toFile: plist, atomically: true)
    }
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn
        let customPlist = "\(self.account.text!).plist"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)
        data.setValue(value, forKey: "married")
        data.write(toFile: plist, atomically: true)
        print("custom plist = \(plist)")
    }
    
    override func viewDidLoad() {
        if let defaultPListPath = Bundle.main.path(forResource: "UserInfo", ofType: "plist") {
            self.defaultPList = NSDictionary(contentsOfFile: defaultPListPath)
        }
        let plist = UserDefaults.standard
        self.name.text = plist.string(forKey: "name")
        self.married.isOn = plist.bool(forKey: "married")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        let picker = UIPickerView()
        picker.delegate = self
        self.account.inputView = picker
        
        let toobar = UIToolbar()
        // 액세서리 뷰 영역에서 툴바는 시스템에 의해 자동으로 좌표가 정해지고, 항상 화면 폭을 가득 채우도록 렌더링 됨 => 높이만 설정해주면 됨
        toobar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toobar.barTintColor = .lightGray
        self.account.inputAccessoryView = toobar
        
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount(_:))
        
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toobar.setItems([new, flexSpace, done], animated: true)
        done.action = #selector(pickerDone)
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount(_:)))
        self.navigationItem.rightBarButtonItems = [addBtn]
        
        let accountlist = plist.array(forKey: "accountlist") as? [String] ?? [String]()
        self.accountlist = accountlist
        if let account = plist.string(forKey: "selectedAccount") {
            self.account.text = account
            let customPlist = "\(account).plist"
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSDictionary(contentsOfFile: clist)
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
        
        
        if (self.account.text?.isEmpty)! {
            self.account.placeholder = "등록된 계정이 없습니다."
            self.gender.isEnabled = false
            self.married.isEnabled = false
            
        }
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 && !(self.account.text?.isEmpty)! {
            let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
            alert.addTextField() {
                $0.text = self.name.text
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default) {(_) in
                let value = alert.textFields?[0].text
                let customPlist = "\(self.account.text!).plist"
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let path = paths[0] as NSString
                let plist = path.strings(byAppendingPaths: [customPlist]).first!
                let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)
                data.setValue(value, forKey: "name")
                data.write(toFile:plist, atomically: true)
                self.name.text = value
            })
            self.present(alert, animated: false, completion: nil)
        }
    }
    
        @objc func pickerDone(_ sender: Any) {
            self.view.endEditing(true)
            
            if let _account = self.account.text {
                let customPlist = "\(_account).plist"
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let path = paths[0] as NSString
                let clist = path.strings(byAppendingPaths: [customPlist]).first!
                let data = NSDictionary(contentsOfFile: clist)
                self.name.text = data?["name"] as? String
                self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
                self.married.isOn = data?["married"] as? Bool ?? false
            }
        }
        @objc func newAccount(_ sender: Any) {
            self.view.endEditing(true)
            let alert = UIAlertController(title: "새 계정을 입력하세요", message: nil, preferredStyle: .alert)
            alert.addTextField(){
                $0.placeholder = "ex) abc@gmail.com"
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
                if let account = alert.textFields?[0].text {
                    self.accountlist.append(account)
                    self.account.text = account
                    self.name.text = ""
                    self.gender.selectedSegmentIndex = 0
                    self.married.isOn = false
                    let plist = UserDefaults.standard
                    plist.set(self.accountlist, forKey: "accountlist")
                    plist.set(account, forKey: "selectedAccount")
                    plist.synchronize()
                    self.gender.isEnabled = true
                    self.married.isEnabled = true
                }
            })
            self.present(alert, animated: false, completion: nil)
    }
}
