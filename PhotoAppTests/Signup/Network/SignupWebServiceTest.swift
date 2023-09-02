//
//  SignupWebServiceTest.swift
//  PhotoAppTests
//
//  Created by Matteo Buompastore on 19/08/23.
//

import XCTest
@testable import PhotoApp

final class SignupWebServiceTest: XCTestCase {
    
    var sut : SignupWebService!
    var signFormRequestModel : SignFormRequestModel!
    var urlSession : URLSession!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockUrlProtocol.self]
        urlSession = URLSession(configuration: config)
        sut = SignupWebService(urlString: SignupConstants.signupUrl, urlSession: urlSession)
        signFormRequestModel = SignFormRequestModel(firstName: "Matteo", lastName: "Buom", email: "mat@gmail.com", password: "123456")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        signFormRequestModel = nil
        MockUrlProtocol.stubResponseData = nil
        MockUrlProtocol.error = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testSignupWebService_WhenGivenSuccessfulResponse_ReturnSuccess() {
        //Arrange
        let jsonString = "{\"status\":\"ok\"}"
        MockUrlProtocol.stubResponseData = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "Signup web service expectation")
        
        //Act
        sut.signup(withForm: signFormRequestModel) {signupResponseModel, error in
            //Assert
            //"{\"status\":\"ok\"}"
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    func testSignupWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        //Arrange
        let jsonString = "{\"path\":\"users\", \"error\":\"Internal Server Error\"}"
        MockUrlProtocol.stubResponseData = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "Signup method expectation for a response that contains a different JSON structure")
        
        //Act
        sut.signup(withForm: signFormRequestModel) {signupResponseModel, error in
            //Assert
            //"{\"status\":\"ok\"}"
            XCTAssertNil(signupResponseModel, "The response model for a request containing unknown JSON response should have been nil")
            XCTAssertEqual(error, SignupError.responseModelParsing, "Signup method did not return expected error")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenEmptyUrlStringProvided_ReturnError() {
        //Arrange
        let expectation = self.expectation(description: "An empty request URL string expectation")
        sut = SignupWebService(urlString: "")
        
        //Act
        sut.signup(withForm: signFormRequestModel) { response, error in
            //Assert
            XCTAssertEqual(error, SignupError.invalidRequestURLString, "Signup method did not return expected error for an invalidRequestURLStringError")
            XCTAssertNil(response, "When an invalidRequestURLStringError takes place, the response model must be nil")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        //Arrange
        let expectation = self.expectation(description: "A failed request expectation")
        let description = "A localized description of an error"
        MockUrlProtocol.error = SignupError.failedRequest(description: description)
        
        //Act
        sut.signup(withForm: signFormRequestModel) { response, error in
            //Assert
            XCTAssertEqual(error, SignupError.failedRequest(description: description), "The signup method did not return an expected error for the failed request")
            XCTAssertEqual(error?.localizedDescription, description)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
        
    }

}
