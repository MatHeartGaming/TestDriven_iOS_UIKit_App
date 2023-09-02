//
//  MockSignupViewDelegate.swift
//  PhotoAppTests
//
//  Created by Matteo Buompastore on 20/08/23.
//

import Foundation
import XCTest
@testable import PhotoApp

class MockSignupViewDelegate : SignupViewDelegateProtocol {
    
    var expectation : XCTestExpectation?
    var successfulSignupCounter : Int = 0
    var errorHandlerCounter : Int = 0
    var signupViewError : SignupError?
    
    func successfulSignup() {
        successfulSignupCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: PhotoApp.SignupError) {
        signupViewError = error
        errorHandlerCounter += 1
        expectation?.fulfill()
    }
    
    
    
}
