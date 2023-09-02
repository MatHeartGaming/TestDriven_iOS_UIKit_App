//
//  MockSignupWebService.swift
//  PhotoAppTests
//
//  Created by Matteo Buompastore on 20/08/23.
//

import Foundation
@testable import PhotoApp

class MockSignupWebService : SignupWebServiceProtocol {
    
    var isSignupMethodCalled : Bool = false
    var shouldReturnError : Bool = false
    
    func signup(withForm formModel: PhotoApp.SignFormRequestModel, completionHandler: @escaping (PhotoApp.SignupResponseModel?, PhotoApp.SignupError?) -> Void) {
        isSignupMethodCalled = true
        if !shouldReturnError {
            let signupResponseModel = SignupResponseModel(status: "OK")
            completionHandler(signupResponseModel, nil)
        } else {
            completionHandler(nil, SignupError.failedRequest(description: "The request failed"))
        }
    }
    
}
