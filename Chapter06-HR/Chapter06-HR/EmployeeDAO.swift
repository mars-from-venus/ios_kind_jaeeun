//
//  EmployeeDAO.swift
//  Chapter06-HR
//
//  Created by mars on 2021/08/09.
//

import UIKit

enum EmpStateType : Int {
    case ING = 0
    case STOP = 1
    case OUT = 2
    
    func desc() -> String {
        switch self {
        case .ING:
            return "재직중"
        case .OUT:
            return "퇴사"
        case .STOP:
            return "휴직"
        }
    }
}

struct EmployeeVO {
    var empCd = 0
    var empName = ""
    var joinDate = ""
    var stateCd = EmpStateType.ING
    var departCd = 0
    var departTitle = ""
}

class EmployeeDAO {
    lazy var fmdb: FMDatabase! = {
        let fileMgr = FileManager.default
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        let db = FMDatabase(path: dbPath)
        return db
    }()
    
    func find(departCd: Int = 0 ) -> [EmployeeVO] {
        var employeeList = [EmployeeVO]()
        do {
            // 1. 조건절 정의
            let condition = departCd == 0 ? "" : "WHERE Employee.depart_cd = \(departCd)"
            
            let sql = """
            SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
            FROM employee
            JOIN department On department.depart_cd = employee.depart_cd
            \(condition)
            ORDER BY employee.depart_cd ASC
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                var record = EmployeeVO()
                record.empCd = Int(rs.int(forColumn: "emp_cd"))
                record.empName = rs.string(forColumn: "emp_name")!
                record.joinDate = rs.string(forColumn: "join_date")!
                record.departTitle = rs.string(forColumn: "depart_title")!
                
                let cd = Int(rs.int(forColumn: "state_cd"))
                record.stateCd = EmpStateType(rawValue: cd)!
                employeeList.append(record)
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return employeeList
    }
    // 단일 사원 레코드
    func get(empCd: Int) -> EmployeeVO? {
        let sql = """
        SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
        FROM empolyee
        JOIN department On department.depart_cd = employee.depart_cd
        WHERE emp_cd = ?
        """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [empCd])
        if let _rs = rs {
            _rs.next()
            
            var record = EmployeeVO()
            record.empCd = Int(_rs.int(forColumn: "emp_cd"))
            record.empName = _rs.string(forColumn: "emp_name")!
            record.joinDate = _rs.string(forColumn: "join_date")!
            record.departTitle = _rs.string(forColumn: "depart_title")!
            
            let cd = Int(_rs.int(forColumn: "state_cd"))
            record.stateCd = EmpStateType.init(rawValue: cd)!
            return record
        } else {
            return nil
        }
    }
    
    func create(param: EmployeeVO) -> Bool {
        do {
            let sql = """
            INSERT INTO employee (emp_name, join_date, state_cd, depart_cd)
            VALUES ( ?, ?, ?, ? )
            """
            // 선처리구문을 위한 인자값
            // 서로 다른 타입의 값을 배열에 담기 위해 초기화 시 타입을 Any로 지정
            var params = [Any]()
            params.append(param.empName)
            params.append(param.joinDate)
            params.append(param.stateCd.rawValue)
            params.append(param.departCd)
            
            try self.fmdb.executeUpdate(sql, values: params)
            return true
        } catch let error as NSError {
            print("Insert Error: \(error.localizedDescription)")
            return false
        }
    }
    
    func remove(empCd:Int) -> Bool {
        do {
            let sql = "DELETE FROM employee WHERE emp_cd = ? "
            try self.fmdb.executeUpdate( sql, values: [empCd])
            return true
        } catch let error as NSError {
            print("Insert Error: \(error.localizedDescription)")
            return false
        }
    }
    
    func editState(empCd: Int , stateCd: EmpStateType) -> Bool {
        do {
            let sql = " UPDATE Employee SET state_cd = ? WHERE emp_cd = ? " // 인자값 배열
            var params = [Any]()
            params.append(stateCd.rawValue) // 재직 상태 코드 0,1,2
            params.append(empCd) // 사원 코드
            
            try self.fmdb.executeUpdate(sql, values: params)
            return true
        } catch let error as NSError {
            print("UPDATE Error: \(error.localizedDescription)")
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
