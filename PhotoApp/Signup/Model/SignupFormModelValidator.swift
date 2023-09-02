//
//  SignupFormModelValidator.swift
//  PhotoApp
//
//  Created by Matteo Buompastore on 17/08/23.
//

import Foundation

class SignupFormModelValidator : SignupModelValidatorProtocol {
    
    func isFirstNameValid(firstName : String) -> Bool {
        var returnValue = true
        if firstName.count < SignupConstants.firstNameMinLenght || firstName.count > SignupConstants.firstNameMaxLenght {
            returnValue = false
        }
        return returnValue
    }
    
    func isLastNameValid(firstName : String) -> Bool {
        var returnValue = true
        if firstName.count < SignupConstants.firstNameMinLenght || firstName.count > SignupConstants.firstNameMaxLenght {
            returnValue = false
        }
        return returnValue
    }
    
    func isEmailValid(email : String) -> Bool {
        var returnValue = true
        if email.count < SignupConstants.emailMinLenght || !email.contains("@") {
            returnValue = false
        }
        return returnValue
    }
    
    func isPasswordValid(password : String) -> Bool {
        var returnValue = true
        if password.count < SignupConstants.passwordMinLenght {
            returnValue = false
        }
        return returnValue
    }
    
    func doPasswordMatch(password : String, repeatPassword : String) -> Bool {
        return password == repeatPassword
    }
    
}
