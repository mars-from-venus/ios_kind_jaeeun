//
//  ViewController.swift
//  Chapter06-SQLite3
//
//  Created by mars on 2021/08/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let dbPath = self.getDBPath()
        self.dbExecute(dbPath: dbPath)
        }
    
    func dbExecute(dbPath: String) {
        // let dbPath = "/Users/mars/db.sqlite"
        
        // SQL 작성 (순서 중요)
        
        var db: OpaquePointer? = nil // SQLite 연결 정보를 담을 변수
        // &연산자 <= 인자값을 참조 방식으로 전달하기 위한 연산자, 레퍼런스 전달의 방식
        guard sqlite3_open(dbPath, &db) == SQLITE_OK else {  // 데이터베이스가 연결되었다면
            print("Database Connect Fail")
            return
        }
        
        // 데이터베이스 연결 종료 defer --> 중복 작성을 피하면서 반드시 실행될 수 있게 함
        defer {
            print("Close Database Connection")
            // DB 연결을 해제한다
            sqlite3_close(db) // prepare의 실행 결과와 상관없이 확실하게 실행될 수 있는 위치에 작성
        }
        
        var stmt: OpaquePointer? = nil // 컴파일된 SQL 정보를 담을 변수
        // sequence라는 이름의 테이블, 하나의 INTEGER 타입 칼럼을 가지며, 칼럼명은 num
        let sql = "CREATE TABLE IF NOT EXISTS sequence (num INTEGER)"
        // db와 sql은 입력값, stmt는 출력값
        guard sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK else {  // 컴파일이 잘 끝났다면
            print("Prepare Statement Fail")
            return
            }
        
        // stmt 변수 해제. defer 블록은 함수나 메소드에서 코드의 흐름과 상관없이 가장 마지막에 실행되는 블록
        defer {
            print("Finalize Statement")
            // 컴파일된 SQL 객체를 해제한다
            sqlite3_finalize(stmt)
        }
        
        
        if sqlite3_step(stmt) == SQLITE_DONE {
                    print("Create Table Success!")
        }

    }
    
        func getDBPath() -> String {
            // SQLite 데이터베이스 파일의 전체경로
            let fileMgr = FileManager()
            // 1.url메소드는 지정된 도메인 범위에서 원하는 디렉터리 경로를 찾아줌, url 객체를 배열 형태로 반환
            let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
            // 2.URL 객체 타입을 문자열 타입으로 변환 path 이용
            let dbPath = docPathURL.appendingPathComponent("db.sqlite").path
            if fileMgr.fileExists(atPath: dbPath) == false {
                let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")
                try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
            }
            return dbPath
        }
}



