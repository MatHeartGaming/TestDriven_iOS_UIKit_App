//
//  PhotoAppUITests.swift
//  PhotoAppUITests
//
//  Created by Matteo Buompastore on 15/08/23.
//

import XCTest
@testable import PhotoApp

final class SignupFlowUITests: XCTestCase {
    
    private var app : XCUIApplication!
    var firstName : XCUIElement!
    var lastName : XCUIElement!
    var email : XCUIElement!
    var phoneNumber : XCUIElement!
    var password : XCUIElement!
    var repeatPassword : XCUIElement!
    var signupButton : XCUIElement!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        firstName = app.textFields["firstNameTextField"]
        lastName = app.textFields["lastNameTextField"]
        email = app.textFields["emailTextField"]
        phoneNumber = app.textFields["phoneTextField"]
        password = app.secureTextFields["passwordTextField"]
        repeatPassword = app.secureTextFields["repeatPasswordTextField"]
        signupButton = app.buttons["signupButton"]

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        //Arrange
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        try super.tearDownWithError()
    }

    func testSignupViewController_WhenViewLoaded_RequiredUIElementsEnabled() throws {

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        XCTAssertTrue(firstName.isEnabled, "First name UITextField is not enabled for user interaction.")
        XCTAssertTrue(lastName.isEnabled, "Last name UITextField is not enabled for user interaction.")
        XCTAssertTrue(email.isEnabled, "Email UITextField is not enabled for user interaction.")
        XCTAssertTrue(phoneNumber.isEnabled, "Phone Number UITextField is not enabled for user interaction.")
        XCTAssertTrue(password.isEnabled, "Password Secure UITextField is not enabled for user interaction.")
        XCTAssertTrue(repeatPassword.isEnabled, "Repeat Password Secure UITextField is not enabled for user interaction.")
        XCTAssertTrue(signupButton.isEnabled, "Signup Button is not enabled for user interaction.")
    }
    
    func testViewController_WhenInvalidFormSubmitted_PresentsErrorAlertDialog() {
        //Arrange
        
        firstName.tapAndType("M")
        lastName.tapAndType("B")
        email.tapAndType("@")
        phoneNumber.tapAndType("1223323")
        password.tapAndType("123456")
        repeatPassword.tapAndType("123")
        
        //MARK: - SINGLE UI ELEMENT SCREENSHOT
        let phoneNumberScreenshot = phoneNumber.screenshot()
        let phoneNumAttachment = XCTAttachment(screenshot: phoneNumberScreenshot)
        phoneNumAttachment.name = "Phone Number Attachment Screenshot"
        phoneNumAttachment.lifetime = .keepAlways
        add(phoneNumAttachment)
        
        //Act
        signupButton.tap()
        
        //Assert
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1), "The Alert Error Dialog has not been shown.")
        
    }
    
    func testViewController_WhenValidFormSubmitted_PresentsSuucessAlertDialog() {
        //Arrange
        
        firstName.tapAndType("Mat")
        lastName.tapAndType("Buommmm")
        email.tapAndType("mat@gmail.com")
        phoneNumber.tapAndType("1223323")
        password.tapAndType("1234567")
        repeatPassword.tapAndType("1234567")
        
        //Act
        signupButton.tap()
        
        //Assert
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 3), "The Success Dialog has not been shown.")
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIElement {
    
    /// Taps on the UIElement and types the given text into it
    /// - Parameter text: The String to inject into the field
    func tapAndType(_ text : String) {
        self.tap()
        self.typeText(text)
    }
    
}
