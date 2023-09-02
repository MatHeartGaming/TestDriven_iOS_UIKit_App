//
//  SignFormRequestModel.swift
//  PhotoApp
//
//  Created by Matteo Buompastore on 19/08/23.
//

import Foundation

struct SignFormRequestModel : Encodable {
    
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    
}
