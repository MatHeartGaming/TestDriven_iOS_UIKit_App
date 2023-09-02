//
//  SignupViewDelegateProtocol.swift
//  PhotoApp
//
//  Created by Matteo Buompastore on 21/08/23.
//

import Foundation

protocol SignupViewDelegateProtocol : AnyObject {
    func successfulSignup()
    func errorHandler(error: SignupError)
}
