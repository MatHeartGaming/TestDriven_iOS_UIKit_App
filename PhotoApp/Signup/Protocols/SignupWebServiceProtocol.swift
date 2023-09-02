//
//  SignupWebServiceProtocol.swift
//  PhotoApp
//
//  Created by Matteo Buompastore on 20/08/23.
//

import Foundation

protocol SignupWebServiceProtocol {
    
    func signup(withForm formModel: SignFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void)
    
}
