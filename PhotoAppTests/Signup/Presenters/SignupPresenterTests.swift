//
//  SignupPresenterTests.swift
//  PhotoAppTests
//
//  Created by Matteo Buompastore on 20/08/23.
//

import XCTest
@testable import PhotoApp

final class SignupPresenterTests: XCTestCase {
    
    var signupFormModel : SignupFormModel!
    var mockSignupModelValidator : MockSignupModelValidator!
    var mockSignupWebService : MockSignupWebService!
    var sut : SignupPresenter!
    var mockSignupViewDelegate : MockSignupViewDelegate!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //Arrange
        signupFormModel = SignupFormModel(firstName: "Matteo",
                                          lastName: "Buom",
                                          email: "mat@gmail.com",
                                          password: "123456",
                                          repeatPassword: "123456")
        
        //MARK: - MOCKS
        mockSignupWebService = MockSignupWebService()
        mockSignupModelValidator = MockSignupModelValidator()
        mockSignupViewDelegate = MockSignupViewDelegate()
        
        sut = SignupPresenter(formModelValidator: mockSignupModelValidator,
                              signupWebService: mockSignupWebService,
                              delegate : mockSignupViewDelegate
        )
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        signupFormModel = nil
        mockSignupWebService = nil
        mockSignupModelValidator = nil
        mockSignupViewDelegate = nil
    }
    
    func testSignupPresenter_WhenInformationProvided_WillValidateEachProperty() {
        //Act
        sut.processUserSignup(formModel: signupFormModel)
        
        //Assert
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated, "First Name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "Last Name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailValid, "Email was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValid, "Password was not validated")
        XCTAssertTrue(mockSignupModelValidator.doPasswordMatch, "Passwords do not match")
    }
    
    func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod() {
        //Act
        sut.processUserSignup(formModel: signupFormModel)
        
        //Assert
        XCTAssertTrue(mockSignupWebService.isSignupMethodCalled, "The signup method was not called in the SignupWebService class")
        
    }
    
    func testSignupPresenter_WhenSignupOperationSuccessful_CallsSuccessOnViewDelegate() {
        //Arrange
        let myExpectation = self.expectation(description: "Expect the successfulSignup() method to be called")
        mockSignupViewDelegate.expectation = myExpectation
        
        //Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [myExpectation], timeout: 5)
        
        //Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 1, "The successful signup method was called more than once")
    }
    
    func testSignupPresenter_WhenSignupOperationFails_ShouldCallErrorOnDelegate() {
        //Arrange
        let errorExpectation = self.expectation(description: "Expected the error handler to be called")
        mockSignupViewDelegate.expectation = errorExpectation
        mockSignupWebService.shouldReturnError = true
        
        //Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [errorExpectation], timeout: 5)
        
        //Assert
        XCTAssertEqual(mockSignupViewDelegate.errorHandlerCounter, 1, "Either the error method was called more than once, or was not called at all.")
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 0, "The successfull signup counter was not 0Æ")
        XCTAssertNotNil(mockSignupViewDelegate.signupViewError, "The error was nil")
    }
    
}
