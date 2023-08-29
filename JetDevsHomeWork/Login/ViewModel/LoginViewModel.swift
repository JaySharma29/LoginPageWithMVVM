//
//  LoginViewModel.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 29/08/23.
//

import Foundation

class LoginViewModel: NSObject {
    
    override init() {
        super.init()
    }
    
    func apiForGetLoginData(email: String, password: String) {
        let result = APIClient.shared.sendPost(loginRequestModel: LoginRequestModel(email: email, password: password))
        if let resultFound = result as? LoginResponse {
            debugPrint(resultFound)
        }
        debugPrint(result)
    }

    func validateEnteredDetail(email: String, password: String, complition: @escaping ((Bool, String) -> Void)) {
        if email == "" || password == "" {
            complition(false, "Email and password can not be blank")
        } else if !self.isValidEmail(email: email) {
            complition(false, "Invalid email id")
        } else if password.count <= 6 {
            complition(false, "Password should be 6 digits long")
        } else {
            complition(true, "")
        }
    }
 
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
}
