//
//  FormValidation.swift
//  Students101
//
//  Created by Emmanuel George on 16/09/22.
//

import Foundation

class FormValidation:NSObject{
    static let shared = FormValidation()
    
    public func validaname(name: String) -> Bool {
        let nameRegex = K.RegexPattern.nameRegex
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return validateName.evaluate(with: name)
    }
    public func validaPhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberRegex = K.RegexPattern.phoneRegex
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return validatePhone.evaluate(with: phoneNumber)
    }
    public func validateEmailId(emailID: String) -> Bool {
        let emailRegEx = K.RegexPattern.emailRegex
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailID)
    }
}
