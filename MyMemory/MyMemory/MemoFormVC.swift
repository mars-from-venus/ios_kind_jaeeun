//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by mars on 2021/07/17.
//

import UIKit
import Photos

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate{
    
    
    @IBOutlet var txt_view: UITextView!
    @IBOutlet weak var img_view: UIImageView!
    var subject: String!
    lazy var dao = MemoDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.txt_view.delegate = self
        requestCameraPermission()
        
        let bgImage = UIImage(named: "memo-background.png")!
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        
        self.txt_view.layer.borderWidth = 0
        self.txt_view.layer.borderColor = UIColor.clear.cgColor
        self.txt_view.backgroundColor = UIColor.clear
        
        let style = NSMutableParagraphStyle() // 문단 스타일을 정의하는 클래스
        style.lineSpacing = 9
        self.txt_view.attributedText = NSAttributedString(string: " ", attributes: [.paragraphStyle : style])
        self.txt_view.text = ""
    }
    @IBAction func btn_save(_ sender: Any) {
        // 경고창에 사용될 콘텐츠 뷰 컨트롤러 구성
        let alertV = UIViewController()
        let iconImage = UIImage(named: "warning-icon-60")
        alertV.view = UIImageView(image: iconImage)
        alertV.preferredContentSize = iconImage?.size ?? CGSize.zero
        
        guard self.txt_view.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.setValue(alertV, forKey: "contentViewController")
            self.present(alert, animated: true)
            return
        }
        let data = MemoData()
        data.title = self.subject
        data.contents = self.txt_view.text
        data.image = self.img_view.image
        data.regdate = Date()

        // 코어 데이터에 메모 데이터를 추가한다.
        self.dao.insert(data)
        
        _ = self.navigationController?.popViewController(animated: true)


    }
    @IBAction func btn_camera(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "이미지를 가져올 곳을 선택해주세요", preferredStyle: .actionSheet)
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        alert.addAction(UIAlertAction(title: "카메라", style: .default) {(_) in
            picker.sourceType = .camera
            self.present(picker, animated: false)
        })
        alert.addAction(UIAlertAction(title: "저장앨범", style: .default) { (_) in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: false)
        })
        self.present(alert, animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.img_view.image = info[.editedImage] as? UIImage
        picker.dismiss(animated: false)
    }
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let lenghth = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: lenghth))
        
        self.navigationItem.title = self.subject
    }
    
    func requestCameraPermission(){
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    print("Camera: 권한 허용")
                } else {
                    print("Camera: 권한 거부")
                }
            })
        }
    //네비게이션 바의 토글 처리
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = self.navigationController?.navigationBar
        let ts = TimeInterval(0.3)
        UIView.animate(withDuration: ts) {
            bar?.alpha = ( bar?.alpha == 0 ? 1 : 0)
        }
    }


}
