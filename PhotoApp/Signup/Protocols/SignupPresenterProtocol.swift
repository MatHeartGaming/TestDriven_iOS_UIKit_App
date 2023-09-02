//
//  SignupPresenterProtocol.swift
//  PhotoApp
//
//  Created by Matteo Buompastore on 26/08/23.
//

import Foundation

protocol SignupPresenterProtocol : AnyObject {
    
    func processUserSignup(formModel: SignupFormModel)
    
}
