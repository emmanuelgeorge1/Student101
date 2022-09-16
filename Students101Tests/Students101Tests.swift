//
//  Students101Tests.swift
//  Students101Tests
//
//  Created by Emmanuel George on 09/09/22.
//

import XCTest
@testable import Students101
import CoreData

class Students101Tests: XCTestCase {
    
    var studentDataManger:CoreDataServices!
    var formValidation:FormValidation!
    
    override func setUp() {
        super.setUp()
        studentDataManger = CoreDataServices()
        formValidation = FormValidation()
    }
    var studentsFetched = [StudentInfo]()
    func test_create_Students(){
        let studentDict = ["firstName":"Emmanuel",
                           "lastName":"george",
                           "email":"1@2.com",
                           "phone":"9876543210",
                           "adress":"Arimbasdf",
                           "course":"B.Tech",
                           "dob":"20-05-1998",
                           "blood":"B+"]
        studentDataManger.saveStudentData(studentDict: studentDict )
        studentsFetched = studentDataManger.getStudentsList()
        //  XCTAssertNil(studentsFetched,"Nil")
        XCTAssertNotNil(studentsFetched,"Saved New Student Details")
        //        XCTAssertEqualDictionaries(first: studentDict as! [String : String], studentsFetched as! [String:String] )
        
    }
    
    //    func XCTAssertEqualDictionaries(first: [String:String], _ second: [String:String]) {
    //
    //        XCTAssert(first == second)
    //    }
    
    func test_email_validation(){
      //  let correctEmail = "1@2.com"
        let incorrectEmail = "qwert"
       let validEmail = formValidation.validateEmailId(emailID: incorrectEmail)
      XCTAssertEqual(false, validEmail)
    }
    
}
