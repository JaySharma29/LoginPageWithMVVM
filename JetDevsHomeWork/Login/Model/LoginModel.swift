//
//  LoginModel.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 29/08/23.
//

import Foundation
struct LoginResponse: Codable {
    
    let result: Int?
    let errorMessage: String?
    let data: LoginData?
    
    private enum CodingKeys: String, CodingKey {
        case result = "result"
        case errorMessage = "error_message"
        case data = "data"
    }
}
struct LoginData: Codable {
    
    let user: User?
}

struct User: Codable {
    
    let userId: Int?
    let userName: String?
    let profileImage: String?
    let createdAt: String?
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case userName = "user_name"
        case profileImage = "user_profile_url"
        case createdAt = "created_at"
    }
    
}
