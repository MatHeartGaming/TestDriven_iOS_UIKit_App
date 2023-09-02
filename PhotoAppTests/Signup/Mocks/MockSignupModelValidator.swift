//
//  MockSignupModelValidator.swift
//  PhotoAppTests
//
//  Created by Matteo Buompastore on 20/08/23.
//

import Foundation
@testable import PhotoApp

class MockSignupModelValidator : SignupModelValidatorProtocol {
    
    //MARK: - PROPERTIES
    var isFirstNameValidated : Bool = false
    var isLastNameValidated : Bool = false
    var isEmailValid : Bool = false
    var isPasswordValid : Bool = false
    var doPasswordMatch : Bool = false
    
    
    
    //MARK: - FUNCTIONS
    
    func isFirstNameValid(firstName: String) -> Bool {
        isFirstNameValidated = true
        return true
    }
    
    func isLastNameValid(firstName: String) -> Bool {
        isLastNameValidated = true
        return true
    }
    
    func isEmailValid(email: String) -> Bool {
        isEmailValid = true
        return true
    }
    
    func isPasswordValid(password: String) -> Bool {
        isPasswordValid = true
        return true
    }
    
    func doPasswordMatch(password: String, repeatPassword: String) -> Bool {
        doPasswordMatch = true
        return true
    }
    
}
