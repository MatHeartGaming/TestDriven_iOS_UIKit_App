//
//  SignupErrors.swift
//  PhotoApp
//
//  Created by Matteo Buompastore on 19/08/23.
//

import Foundation

enum SignupError : LocalizedError, Equatable {
    case responseModelParsing
    case invalidRequestURLString
    case failedRequest(description: String)
    case firstNameInvalid
    case lastNameInvalid
    case emailInvalid
    case phoneInvalid
    case passwordInvalid
    case repeatPasswordInvalid
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidRequestURLString, .responseModelParsing, .firstNameInvalid, .lastNameInvalid, .emailInvalid, .phoneInvalid, .passwordInvalid, .repeatPasswordInvalid: return ""
        }
    }
}
