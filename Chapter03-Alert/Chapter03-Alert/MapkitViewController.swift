//
//  MapkitViewController.swift
//  Chapter03-Alert
//
//  Created by mars on 2021/07/25.
//

import UIKit
import MapKit

class MapkitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mapkitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view = mapkitView
        self.preferredContentSize.height = 200
        
        let pos = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: pos, span: span)
        mapkitView.region = region
        mapkitView.regionThatFits(region)
        
        let point = MKPointAnnotation()
        point.coordinate = pos //coordinate 뜻: 위도와 경도
        mapkitView.addAnnotation(point)
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
