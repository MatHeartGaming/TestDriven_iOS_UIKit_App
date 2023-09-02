//
//  SignupModelValidatorProtocol.swift
//  PhotoApp
//
//  Created by Matteo Buompastore on 20/08/23.
//

import Foundation

protocol SignupModelValidatorProtocol {
    
    func isFirstNameValid(firstName : String) -> Bool
    
    func isLastNameValid(firstName : String) -> Bool
    
    func isEmailValid(email : String) -> Bool
    
    func isPasswordValid(password : String) -> Bool
    
    func doPasswordMatch(password : String, repeatPassword : String) -> Bool
    
}
