//
//  UIColor+Extension.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 29/08/23.
//

import UIKit

class JetDevHomeworkTheme: NSObject {
    
    static func colorFrom(hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat((hex & 0xff0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00ff00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000ff) / 255.0,
            alpha: alpha
        )
    }
    
    static let loginButtonDisableState: UIColor = colorFrom(hex: 0xBDBDBD)
    static let loginButtonSelectedState: UIColor = colorFrom(hex: 0x28518D)
    static let textFieldBorderColor: UIColor = colorFrom(hex: 0xBDBDBD)
    static let buttonTextColor: UIColor = .white
}
