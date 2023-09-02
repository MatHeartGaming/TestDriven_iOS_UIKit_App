//
//  SignupViewController.swift
//  PhotoApp
//
//  Created by Matteo Buompastore on 23/08/23.
//

import UIKit

class SignupViewController: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var phoneNumber: UITextField!
    
    var signupPresenter : SignupPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //if signupButton == nil {
            let signupModelValidator = SignupFormModelValidator()
            let webServices = SignupWebService(urlString: SignupConstants.signupUrl)
            let delegate = self
            signupPresenter = SignupPresenter(formModelValidator: signupModelValidator, signupWebService: webServices, delegate: delegate)
        //}
    }
    
    @IBAction func signupButtonTap(_ sender: Any) {
        let signupFormModel = SignupFormModel(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, repeatPassword: repeatPasswordTextField.text!)
        signupPresenter?.processUserSignup(formModel: signupFormModel)
    }
    

}

extension SignupViewController : SignupViewDelegateProtocol {
    func successfulSignup() {
        let alert = UIAlertController(title: "Success", message: "Your request has been successful", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "successAlertDialog"
            self.present(alert, animated: true)
        }
    }
    
    func errorHandler(error: SignupError) {
        let alert = UIAlertController(title: "Error", message: "Your request could not be processed at this time", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alert, animated: true)
        }
    }
    
    
}
