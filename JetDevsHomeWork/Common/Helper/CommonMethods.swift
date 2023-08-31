//
//  CommonMethods.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 31/08/23.
//

import Foundation
import UIKit

func daysBetweenDates(dateString: String) -> Int? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Account.dateFormatterForCreateAccount

    if let date = dateFormatter.date(from: dateString) {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let components = calendar.dateComponents([.day], from: date, to: currentDate)
        return components.day
    }
    return nil
}

func isValidEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
}
