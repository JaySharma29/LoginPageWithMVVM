//
//  LoginViewController.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 29/08/23.
//

import UIKit
import MaterialComponents

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: MDCOutlinedTextField!
    @IBOutlet weak var textFieldPassword: MDCOutlinedTextField!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        textFieldEmail.label.text = "Email"
        textFieldEmail.placeholder = "Email"
        textFieldPassword.label.text = "Password"
        textFieldPassword.placeholder = "Password"
        textFieldEmail.layer.borderColor = JetDevHomeworkTheme.textFieldBorderColor.cgColor
        textFieldEmail.setOutlineColor(JetDevHomeworkTheme.textFieldBorderColor, for: .editing)
        textFieldEmail.setOutlineColor(JetDevHomeworkTheme.textFieldBorderColor, for: .disabled)
        textFieldEmail.setOutlineColor(JetDevHomeworkTheme.textFieldBorderColor, for: .normal)
        textFieldPassword.setOutlineColor(JetDevHomeworkTheme.textFieldBorderColor, for: .editing)
        textFieldPassword.setOutlineColor(JetDevHomeworkTheme.textFieldBorderColor, for: .disabled)
        textFieldPassword.setOutlineColor(JetDevHomeworkTheme.textFieldBorderColor, for: .normal)
        btnLogin.setTitleColor(JetDevHomeworkTheme.buttonTextColor, for: .normal)
        btnLogin.backgroundColor = JetDevHomeworkTheme.loginButtonDisableState
        btnLogin.titleLabel?.font = UIFont.latoSemiBoldFont(size: 18)
        btnLogin.layer.cornerRadius = 5
        btnLogin.clipsToBounds = true
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
        
        btnLogin.titleLabel?.textAlignment = .left
        btnLogin.setAttributedTitle( NSMutableAttributedString(string: "Login", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func loginButtonTap(_ sender: UIButton) {
        
    }
    
    @IBAction func closeButtonTap(_ sender: UIButton) {
        self.pop()
    }
}
