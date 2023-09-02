//
//  SignupPresenter.swift
//  PhotoApp
//
//  Created by Matteo Buompastore on 20/08/23.
//

import Foundation

class SignupPresenter : SignupPresenterProtocol {
    
    private var formModelValidator: SignupModelValidatorProtocol
    private var signupWebService : SignupWebServiceProtocol
    private weak var delegate : SignupViewDelegateProtocol?
    
    init(formModelValidator: SignupModelValidatorProtocol, signupWebService : SignupWebServiceProtocol, delegate : SignupViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.signupWebService = signupWebService
        self.delegate = delegate
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
            delegate?.errorHandler(error: SignupError.firstNameInvalid)
            return
        }
        if !formModelValidator.isLastNameValid(firstName: formModel.lastName) {
            delegate?.errorHandler(error: SignupError.lastNameInvalid)
            return
        }
        if !formModelValidator.isEmailValid(email: formModel.email) {
            delegate?.errorHandler(error: SignupError.emailInvalid)
            return
        }
        if !formModelValidator.isPasswordValid(password: formModel.password) {
            print("Password: \(formModel.password)")
            delegate?.errorHandler(error: SignupError.passwordInvalid)
            return
        }
        if !formModelValidator.doPasswordMatch(password: formModel.password, repeatPassword: formModel.repeatPassword) {
            delegate?.errorHandler(error: SignupError.repeatPasswordInvalid)
            return
        }
        
        let requestModel = SignFormRequestModel(firstName: formModel.firstName, lastName: formModel.lastName, email: formModel.email, password: formModel.password)
        signupWebService.signup(withForm: requestModel) { [weak self] response, error in
            if error != nil {
                self?.delegate?.errorHandler(error: error!)
                return
            }
            if let responseModel = response {
                self?.delegate?.successfulSignup()
                return
            }
        }
    }
    
}
