//
//  MemoData.swift
//  MyMemory
//
//  Created by mars on 2021/07/17.
//

import UIKit
import CoreData

class MemoData {
    var memoIdx: Int?
    var title: String?
    var contents: String?
    var image: UIImage?
    var regdate: Date?
    var objectID: NSManagedObjectID? // 원본 MemoMO 객체를 참조하기 위한 속성
}
