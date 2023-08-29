//
//  LoginModel.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 29/08/23.
//

import Foundation

struct LoginResponse: Codable {
    let result: Int?
    let error_message: String?
    let data: LoginData?
}

struct LoginData: Codable {
    let user: User?
}

struct User: Codable {
    let user_id: Int?
    let user_name: String?
    let user_profile_url: String?
    let created_at: String?
}
