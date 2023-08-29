//
//  NSObject+Extension.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 29/08/23.
//

import Foundation
extension NSObject {

    static var className: String {
        return String(describing: self)
    }
}
