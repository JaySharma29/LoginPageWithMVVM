//
//  CommonMethods.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 31/08/23.
//

import Foundation
import UIKit

let userDefaults = UserDefaults.standard

func setValueInUserDefault(key: String, value: Any) {
    userDefaults.setValue(value, forKey: key)
}

func getValueFromUserDefault(key: String) -> Any {
    userDefaults.value(forKey: key) as Any
}

func setCustomUserObjectInUserDefault(loginResponse: LoginResponse) {
    let encoder = JSONEncoder()
    if let encodedData = try? encoder.encode(loginResponse) {
        // Save the data to UserDefaults
        userDefaults.set(encodedData, forKey: Login.user)
    }
}

func getCustomUserObjectInUserDefault() -> LoginResponse? {
    if let savedData = userDefaults.data(forKey: Login.user) {
        let decoder = JSONDecoder()
        if let loadedUser = try? decoder.decode(LoginResponse.self, from: savedData) {
            return loadedUser
        }
    }
    return nil
}

