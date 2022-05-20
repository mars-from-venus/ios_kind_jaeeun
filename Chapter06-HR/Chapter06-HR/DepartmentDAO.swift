//
//  DepartmentDAO.swift
//  Chapter06-HR
//
//  Created by mars on 2021/08/07.
//

import UIKit

class DepartmentDAO {
    
    typealias DepartRecord = (Int, String, String)
    // 참조 되기 전까지 초기화 되지않음, 참조되도 한번만 초기화 실행
    // SQLite 연결 및 초기화
    lazy var fmdb : FMDatabase! = {
        // 1. 파일 매니저 객체를 생성
        let fileMgr = FileManager.default
        // 2. 샌드박스 내 문서 디렉토리에서 데이터베이스 파일 경로를 확인
        var docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        // 3. 샌드박스 경로에 파일이 없다면 메인 번들에 만들어 둔 hr.sqlite를 가져와 복사
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        // 4. 준비된 데이터베이스 파일을 바탕으로 FMDatabase 객체를 생성
        let db = FMDatabase(path: dbPath)
        return db
    }()
    
    func find() -> [DepartRecord] {
        var departList = [DepartRecord]()
        do {
            // 1. 부서 정보 목록을 가져올 SQL 작성 및 쿼리 실행
            let sql = """
            SELECT depart_cd, depart_title, depart_addr
            FROM department
            ORDER BY depart_cd ASC
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            // 2. 결과 집합 추출
            while rs.next() {
                let departCd = rs.int(forColumn: "depart_cd")
                let departTitle = rs.string(forColumn: "depart_title")
                let departAddr = rs.string(forColumn: "depart_addr")
                // append 메소드 호출 시 아래 튜플을 괄호 없이 사용하지 않도록 주의
                departList.append((Int(departCd), departTitle!, departAddr!))
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return departList
    }
    
    func get(departCd: Int) -> DepartRecord? {
        let sql = """
        SELECT depart_cd, depart_title, depart_addr
        FROM department
        WHERE depart_cd = ?
        """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [departCd])
        // 옵셔널 바인딩의 방법으로 상수에 대입
        if let _rs = rs {
            _rs.next()
            let departId = _rs.int(forColumn: "depart_cd")
            let departTitle = _rs.string(forColumn: "depart_title")
            let departAddr = _rs.string(forColumn: "depart_addr")
            return (Int(departId), departTitle!, departAddr!)
        }else {
            return nil
        }
    }
    
    func create(title:String!, addr:String!) -> Bool {
        do{
            let sql = """
            INSERT INTO department (depart_title, depart_addr)
            VALUES ( ? , ? )
            """
            try self.fmdb.executeUpdate(sql, values:[title!, addr!])
           return true
        } catch let error as NSError {
            print("Insert Error: \(error.localizedDescription)")
            return false
        }
    }
    
    func remove(departCd: Int) -> Bool {
        do {
            let sql = "DELETE FROM department WHERE depart_cd = ? "
            try self.fmdb.executeUpdate(sql, values: [departCd])
            return true
        } catch let error as NSError {
            print("Delete Error: \(error.localizedDescription)")
            return false
        }
    }
    
    init() {
        self.fmdb.open()
    }
    
    deinit {
        self.fmdb.close()
    }
}
