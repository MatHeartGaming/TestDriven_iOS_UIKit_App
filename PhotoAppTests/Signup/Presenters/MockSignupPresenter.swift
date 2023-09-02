//
//  MockSignupPresenter.swift
//  PhotoAppTests
//
//  Created by Matteo Buompastore on 26/08/23.
//

import Foundation
@testable import PhotoApp

class MockSignupPresenter : SignupPresenterProtocol {
    
    //MARK: - PROPERTIES
    private var formModelValidator: SignupModelValidatorProtocol
    private var signupWebService : SignupWebServiceProtocol
    private weak var delegate : SignupViewDelegateProtocol?
    var processUserSignupCalled : Bool = false
    
    init(formModelValidator: SignupModelValidatorProtocol, signupWebService : SignupWebServiceProtocol, delegate : SignupViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.signupWebService = signupWebService
        self.delegate = delegate
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        processUserSignupCalled = true
    }
    
}

