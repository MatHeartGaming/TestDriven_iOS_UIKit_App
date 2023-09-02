//
//  SignupViewControllerTests.swift
//  PhotoAppTests
//
//  Created by Matteo Buompastore on 23/08/23.
//

import XCTest
@testable import PhotoApp

final class SignupViewControllerTests: XCTestCase {
    
    var sut : SignupViewController!
    var storyboard : UIStoryboard!
    //var mockSignupPresenter : MockSignupPresenter!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController)
        sut.loadViewIfNeeded()
        //mockSignupPresenter = MockSignupPresenter(formModelValidator: <#SignupModelValidatorProtocol#>, signupWebService: <#SignupWebServiceProtocol#>, delegate: <#SignupViewDelegateProtocol#>)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        sut = nil
        //mockSignupPresenter = nil
    }
    
    func testSignupViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        //Arrange
        
        
        //Act
        
        
        //Assert
        //MARK: - Check there's an outlet for each field connected to the View Contoller
        let firstNameTextField = try XCTUnwrap(sut.firstNameTextField, "The firstNameTextField is not connected to an IBOutlet")
        let lastNameTextField = try XCTUnwrap(sut.lastNameTextField, "The lastNameTextField is not connected to an IBOutlet")
        let emailTextField = try XCTUnwrap(sut.emailTextField, "The emailTextField is not connected to an IBOutlet")
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "The passwordTextField is not connected to an IBOutlet")
        let repeatPasswordTextField = try XCTUnwrap(sut.repeatPasswordTextField, "The repeatPasswordTextField is not connected to an IBOutlet")
        
        XCTAssertEqual(firstNameTextField.text, "", "First name text field was not empty when the view loaded")
        XCTAssertEqual(lastNameTextField.text, "", "Last name text field was not empty when the view loaded")
        XCTAssertEqual(emailTextField.text, "", "Email text field was not empty when the view loaded")
        XCTAssertEqual(passwordTextField.text, "", "Password text field was not empty when the view loaded")
        XCTAssertEqual(repeatPasswordTextField.text, "", "Repeat password text field was not empty when the view loaded")
        
    }
    
    func testSignupViewController_WhenCreated_HasSignupButtonAndAction() throws {
        //Arrange
        let signupButton : UIButton = try XCTUnwrap(sut.signupButton, "The signupButton is not connected to an IBOutlet")
        
        //Act
        let signupButtonActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
        
        //Assert
        XCTAssertEqual(signupButtonActions.count, 1, "The Button has a different number of actions assigned.")
        XCTAssertEqual(signupButtonActions.first, "signupButtonTap:", "The signupButton has no action called 'signupButtonTap'")
    }
    
    func testSignupViewController_WhenSignupButtonTap_InvokesSignupProcess() {
        //Arrange
        let mockSignupModelValidator = MockSignupModelValidator()
        let mockSignupWebService = MockSignupWebService()
        let mockSignupViewDelegate = MockSignupViewDelegate()
        let mockSignupPresenter = MockSignupPresenter(formModelValidator: mockSignupModelValidator, signupWebService: mockSignupWebService, delegate: mockSignupViewDelegate)
        
        sut.signupPresenter = mockSignupPresenter
        
        //Act
        sut.signupButton.sendActions(for: .touchUpInside)
        
        //Assert
        XCTAssertTrue(mockSignupPresenter.processUserSignupCalled, "The 'processUserSignup()' action was not called on a Presenter object when the signup button was tapped in a SignupViewController")
    }
    
    func testSignupViewController_WhenCreated_HasEmailAddressContentTypeSet() throws {
        let emailTextField = try XCTUnwrap(sut.emailTextField, "The email text field is not connected")
        
        XCTAssertEqual(emailTextField.textContentType, .emailAddress, "Email Address does not have email address ContentType set")
        
    }
    
    func testSignupViewController_WhenCreated_HasEmailKeyboardTypeSet() throws {
        let emailTextField = try XCTUnwrap(sut.emailTextField, "The email text field is not connected")
        
        XCTAssertEqual(emailTextField.keyboardType, .emailAddress, "Email Address does not have email address KeyboardType set")
        
    }
    
    func testSignupViewController_WhenCreated_HasPasswordSecureTextEntryField() throws {
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "The password field is not connected")
        
        XCTAssertTrue(passwordTextField.isSecureTextEntry, "Password does not have SecureTextEntry enabled")
        
    }
    
}
