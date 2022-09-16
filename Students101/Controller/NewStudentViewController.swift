//
//  NewStudentViewController.swift
//  Students101
//
//  Created by Emmanuel George on 11/09/22.
//

import UIKit
class NewStudentViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    var isUpdate = false
    var student : StudentInfo?
    var indexRow = Int()
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var courseTextFeild: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var dobTextFeild: UIDatePicker!
    @IBOutlet weak var bloodGroupTextFeild: UITextField!
    let piker1 = UIPickerView()
    let piker2 = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navBar = navigationController?.navigationBar else{print("no navigation bar found"); return}
        navBar.tintColor = UIColor(red: 0.11, green: 0.26, blue: 0.47, alpha: 1.00)
        piker1.dataSource = self
        piker1.delegate = self
        piker2.dataSource = self
        piker2.delegate = self
        piker1.tag = 1
        piker2.tag = 2;
        courseTextFeild.inputView = piker1
        bloodGroupTextFeild.inputView = piker2
        self.firstName.text = student?.firstName
        self.lastName.text = student?.lastName
        self.email.text = student?.email
        self.phone.text = student?.phone
        self.courseTextFeild.text = student?.course
        self.address.text = student?.adress
        if let studentDob = student?.dob{
            self.dobTextFeild.date = studentDob
        }
        self.bloodGroupTextFeild.text = student?.blood
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if isUpdate{
            buttonSave.setTitle("Update", for: .normal)
            self.navigationItem.title = "Edit Details"
        }else{
            buttonSave.setTitle("Save", for: .normal)
            self.navigationItem.title = "Add New Student"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == piker1 {
            return K.courses.count
            
        } else if pickerView == piker2{
            return K.bloodGroups.count
        }
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == piker1 {
            return K.courses[row]
            
        } else if pickerView == piker2{
            return K.bloodGroups[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == piker1 {
            courseTextFeild.text = K.courses[row]

            self.view.endEditing(false)
        } else if pickerView == piker2{
            bloodGroupTextFeild.text = K.bloodGroups[row]
            self.view.endEditing(false)
        }
        self.view.endEditing(true)
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        guard let firstN = firstName.text,let lastN = lastName.text, let emailId = email.text,let phoneNum = phone.text,let addressInfo = address.text,let course = courseTextFeild.text,let blood = bloodGroupTextFeild.text else {
            return
        }
        let isValidateName = FormValidation.shared.validaname(name: firstN)
        if (isValidateName == false) {
            print("Incorrect name parameter")
            return
        }
        let isValidateEmail = FormValidation.shared.validateEmailId(emailID: emailId)
        if (isValidateEmail == false) {
            print("Incorrect Email")
            return
        }
        let isValidatePhone = FormValidation.shared.validaPhoneNumber(phoneNumber: phoneNum)
        if (isValidatePhone == false) {
            print("Incorrect Phone")
            return
        }
        let studentDict = ["firstName":firstN,
                           "lastName":lastN,
                           "email":emailId,
                           "phone":phoneNum,
                           "adress":addressInfo,
                           "course":course,
                           "dob":dobTextFeild.date,
                           "blood":blood] as [String : Any]
        
        if (firstName.text != "" && lastName.text != ""  && address.text != ""  && courseTextFeild.text != "" && isValidateEmail == true && bloodGroupTextFeild.text != ""  && isValidatePhone == true) {
            print("All fields are correct")
            if isUpdate{
                CoreDataServices.shared.editStudentData(studentDict:studentDict , index: indexRow)
                isUpdate = false
                self.performSegue(withIdentifier: K.studentTableSegue, sender: self)
                
            }
            else{
                CoreDataServices.shared.saveStudentData(studentDict: studentDict)
                self.performSegue(withIdentifier: K.studentTableSegue, sender: self)
            }
        }
        else{
            print("Invalid")
        }
    }
}
