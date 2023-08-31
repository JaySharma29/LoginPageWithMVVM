//
//  AccountViewModel.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 31/08/23.
//

import Foundation

class AccountViewModel: NSObject {
    
    var loginResponse: LoginResponse?
    
    init(loginResponse: LoginResponse) {
        self.loginResponse = loginResponse
    }
}
