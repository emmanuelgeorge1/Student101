//
//  Constant.swift
//  Students101
//
//  Created by Emmanuel George on 16/09/22.
//

import Foundation
struct K {
    static let studentCellId = "StudentTableViewCell"
    static let cellNibStudent = "StudentTableViewCell"
    static let newStudentStoryboardID = "NewStudentVc"
    static let studentTableSegue = "HomeVC"
    static let courses = ["B.Tech", "LLB", "MBBS", "B.Arch","B.Pharma","B.Sc-Nursing"]
    static let bloodGroups = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
    
    struct ImageName {
        static let profilePic = "person.circle"
        static let deleteIcon = "trash.fill"
        static let editIcon = "rectangle.and.pencil.and.ellipsis"
    }
    struct RegexPattern{
        static let nameRegex = "\\w{4,18}"
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let phoneRegex = "^[7-9][0-9]{9}$"
    }
}
