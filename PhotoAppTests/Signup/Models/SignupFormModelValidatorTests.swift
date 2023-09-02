//
//  SignupFormModelValidator.swift
//  PhotoAppTests
//
//  Created by Matteo Buompastore on 17/08/23.
//

import XCTest
@testable import PhotoApp

final class SignupFormModelValidatorTests: XCTestCase {
    
    var sut : SignupFormModelValidator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SignupFormModelValidator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    //MARK: - FIRST NAME
    func testSignupModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() throws {
        //Arrange
        
        
        //Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Matteo")
        
        //Assert
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should return true")
    }
    
    func testSignupModelValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        //Arrange
        
        
        //Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "M")
        
        //Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should return false in case the name is shorter then \(SignupConstants.firstNameMinLenght) characters")
    }
    
    func testSignupModelValidator_WhenTooLongtFirstNameProvided_ShouldReturnFalse() {
        //Arrange
        
        
        //Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Mansnkc xknfdknc x ")
        
        //Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should return false in case the name is longer then \(SignupConstants.firstNameMaxLenght) characters")
    }
    
    
    //MARK: - LAST NAME
    func testSignupModelValidator_WhenValidLastNameProvided_ShouldReturnTrue() throws {
        //Arrange
        
        
        //Act
        let isLasttNameValid = sut.isLastNameValid(firstName: "Matteo")
        
        //Assert
        XCTAssertTrue(isLasttNameValid, "The isLastNameValid() should return true")
    }
    
    func testSignupModelValidator_WhenTooShortLastNameProvided_ShouldReturnFalse() {
        //Arrange
        
        
        //Act
        let isFirstNameValid = sut.isLastNameValid(firstName: "B")
        
        //Assert
        XCTAssertFalse(isFirstNameValid, "The isLastNameValid() should return false in case the name is longer then \(SignupConstants.firstNameMaxLenght) characters")
    }
    
    func testSignupModelValidator_WhenTooLongLastNameProvided_ShouldReturnFalse() {
        //Arrange
        
        
        //Act
        let isLastNameValid = sut.isLastNameValid(firstName: "Mansnkc xknfdknc x ")
        
        //Assert
        XCTAssertFalse(isLastNameValid, "The isFirstNameValid() should return false in case the name is longer then \(SignupConstants.firstNameMaxLenght) characters")
    }
    
    //MARK: - EMAIL
    func testSignupModelValidator_WhenValidEmailProvided_ShouldReturnTrue() throws {
        //Arrange
        
        
        //Act
        let isEmailValid = sut.isEmailValid(email: "mat@gmail.com")
        
        //Assert
        XCTAssertTrue(isEmailValid, "The isEmailValid() should return true")
    }
    
    func testSignupModelValidator_WhenEmailNotConainsTheAtSymbol_ShouldReturnFalse() {
        //Arrange
        
        
        //Act
        let isEmailValid = sut.isEmailValid(email: "mat.budskncdfdfdvcd.com")
        
        //Assert
        XCTAssertFalse(isEmailValid, "The isEmailValid() should return false in case the email does not contain a @")
    }
    
    func testSignupModelValidator_WhenEmailTooShort_ShouldReturnFalse() {
        //Arrange
        
        
        //Act
        let isEmailValid = sut.isEmailValid(email: "matbuo.com")
        
        //Assert
        XCTAssertFalse(isEmailValid, "The isEmailValid() should return false in case the email is shorter than \(SignupConstants.emailMinLenght)")
    }
    
    
    //MARK: - PASSWORD
    func testSignupModelValidator_WhenValidPasswordProvided_ShouldReturnTrue() throws {
        //Arrange
        
        
        //Act
        let isPasswordValid = sut.isPasswordValid(password: "password")
        
        //Assert
        XCTAssertTrue(isPasswordValid, "The isPasswordValid() should return true")
    }
    
    func testSignupModelValidator_WhenPasswordTooShort_ShouldReturnFalse() throws {
        //Arrange
        
        
        //Act
        let isPasswordValid = sut.isPasswordValid(password: "passw")
        
        //Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should return false when the password is shorter than \(SignupConstants.passwordMinLenght)")
    }
    
    func testSignupModelValidator_WhenEqualPasswordProvided_ShouldReturnTrue() {
        //Arrange
        
        //Act
        let doPasswordMatch = sut.doPasswordMatch(password: "123456", repeatPassword: "123456")
        
        //Assert
        XCTAssertTrue(doPasswordMatch, "The doPasswordMatch() should have returned true for matching password but has returned false")
    }
    
    func testSignupModelValidator_WhenNotEqualPasswordProvided_ShouldReturnFalse() {
        //Arrange
        
        //Act
        let doPasswordMatch = sut.doPasswordMatch(password: "123456", repeatPassword: "1234567")
        
        //Assert
        XCTAssertFalse(doPasswordMatch, "The doPasswordMatch() should have returned false for NOT matching passwords but has returned true")
    }

}
