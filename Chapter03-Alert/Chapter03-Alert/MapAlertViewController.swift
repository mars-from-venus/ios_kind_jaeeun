//
//  MapAlertViewController.swift
//  Chapter03-Alert
//
//  Created by mars on 2021/07/25.
//

import UIKit
import MapKit

class MapAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertBtn = UIButton(type: .system)
        alertBtn.frame = CGRect(x: 0, y: 150, width: 100, height: 30)
        alertBtn.center.x = self.view.frame.width / 2
        alertBtn.setTitle("Map Alert", for: .normal)
        alertBtn.addTarget(self, action: #selector(mapAlert(_:)), for: .touchUpInside)
        self.view.addSubview(alertBtn)
        
        let imageBtn = UIButton(type: .system)
        imageBtn.frame = CGRect(x: 0, y: 200, width: 100, height: 30)
        imageBtn.center.x = self.view.frame.width / 2
        imageBtn.setTitle("Image Alert", for: .normal)
        imageBtn.addTarget(self, action: #selector(imageAlert(_:)), for: .touchUpInside)
        self.view.addSubview(imageBtn)
        
        let slierBtn = UIButton(type: .system)
        slierBtn.frame = CGRect(x: 0, y: 250, width: 100, height: 30)
        slierBtn.center.x = self.view.frame.width / 2
        slierBtn.setTitle("Slider Alert", for: .normal)
        slierBtn.addTarget(self, action: #selector(sliderAlert(_:)), for: .touchUpInside)
        self.view.addSubview(slierBtn)
        
        let listBtn = UIButton(type: .system)
        listBtn.frame = CGRect(x: 0, y: 300, width: 100, height: 30)
        listBtn.center.x = self.view.frame.width / 2
        listBtn.setTitle("List Alert", for: .normal)
        listBtn.addTarget(self, action: #selector(listAlert(_:)), for: .touchUpInside)
        self.view.addSubview(listBtn)
    }
    @objc func listAlert(_ sender: Any) {
        let list = ListViewController()
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.setValue(list, forKey:"contentViewController")
        list.delegate = self
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: false)
    }
    
    @objc func sliderAlert(_ sender: Any) {
        let slider = ControlViewController()
        let alert = UIAlertController(title: nil, message: "이번 글의 평점을 입력해주세요", preferredStyle: .alert)
        alert.setValue(slider, forKey:"contentViewController")
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            print(">>> slierValue = \(slider.sliderValue)")
        }
        alert.addAction(okAction)
        self.present(alert, animated: false)
    }
    
    @objc func imageAlert(_ sender: UIButton){
        let alert = UIAlertController(title: nil, message: "이번 글의 평점은 다음과 같습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        let contentVC = ImageViewController()
        alert.setValue(contentVC, forKey: "contentViewController")
        self.present(alert, animated: false)
    }
    
    @objc func mapAlert(_ sender: UIButton) {
        let alertControll = UIAlertController(title: nil, message: "여기가 맞습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertControll.addAction(cancelAction)
        alertControll.addAction(okAction)
        
        let contentVC = MapkitViewController()
       // contentVC.view = MapkitViewController() 맵킷 뷰를 루트뷰로 설정(루트뷰는 항상 화면 전체를 채우는 방식으로 크기가 자동 지정)
       /*
        let mapkitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        //1.위치 정보 설정
        let pos = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623)
        //2.지도에서 보여줄 넓이. 일종의 축척. 숫자가 적을수록 좁은 범위를 확대시켜서 보여줌
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        //3.지도 영역을 정의
        let region = MKCoordinateRegion(center: pos, span: span)
        //4.지도 뷰에 표시
        mapkitView.region = region
        mapkitView.regionThatFits(region)
        //5.위치를 핀으로 표시
        let point = MKPointAnnotation()
        point.coordinate = pos //coordinate 뜻: 위도와 경도
        mapkitView.addAnnotation(point)
        contentVC.preferredContentSize.height = 200
        */
        alertControll.setValue(contentVC, forKey: "contentViewController")
        self.present(alertControll, animated: false)
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        print(">>> 선택된 행은 \(indexPath.row).입니다")
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
