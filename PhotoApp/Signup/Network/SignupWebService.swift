//
//  SignupWebService.swift
//  PhotoApp
//
//  Created by Matteo Buompastore on 19/08/23.
//

import Foundation

class SignupWebService : SignupWebServiceProtocol {
    
    //MARK: - PROPERTIES
    private var urlSession : URLSession
    private var urlString : String
    
    init(urlString: String, urlSession : URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    //MARK: - FUNCTIONS
    func signup(withForm formModel: SignFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, SignupError.invalidRequestURLString)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(formModel)
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            //MARK: - Handle Error
            if error != nil {
                completionHandler(nil, SignupError.failedRequest(description: error!.localizedDescription))
                return
            }
            
            //MARK: - Handle JSON Parse
            if let data = data, let signupResponseModel = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                completionHandler(signupResponseModel, nil)
            } else {
                completionHandler(nil, SignupError.responseModelParsing)
            }
        }
        
        dataTask.resume()
    }
    
}
