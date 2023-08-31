//
//  LoginViewController.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 29/08/23.
//

import UIKit
import MaterialComponents
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: MDCOutlinedTextField!
    @IBOutlet weak var textFieldPassword: MDCOutlinedTextField!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var loginViewModel: LoginViewModel!
    
    var isLoginButtonEnable = false {
        didSet {
            if isLoginButtonEnable {
                btnLogin.backgroundColor = JetDevHomeworkTheme.loginButtonSelectedState
                btnLogin.isEnabled = true
            } else {
                btnLogin.backgroundColor = JetDevHomeworkTheme.loginButtonDisableState
                btnLogin.isEnabled = false
            }
        }
    }
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldEmail.rx.controlEvent(.editingDidEnd)
            .asObservable()
            .map { self.textFieldEmail.text }
            .subscribe(onNext: { email in
                if let email = email {
                    if !email.isEmpty && !(self.textFieldPassword.text ?? "").isEmpty {
                        self.isLoginButtonEnable = true
                    } else {
                        self.isLoginButtonEnable = false
                    }
                }
            }).disposed(by: disposeBag)
        
        self.textFieldPassword.rx.controlEvent(.editingDidEnd)
            .asObservable()
            .map { self.textFieldPassword.text }
            .subscribe(onNext: { password in
                if let password = password {
                    if !password.isEmpty && !(self.textFieldEmail.text ?? "").isEmpty {
                        self.isLoginButtonEnable = true
                    } else {
                        self.isLoginButtonEnable = false
                    }
                }
            }).disposed(by: disposeBag)
        
        loginViewModel = LoginViewModel()
        configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func loginButtonTap(_ sender: UIButton) {
        self.view.endEditing(true)
        let email = (self.textFieldEmail.text ?? "")
        let password = (self.textFieldPassword.text ?? "")
        self.loginViewModel.validateEnteredDetail(loginDetail: LoginRequestModel(email: email, password: password)) { isSuccess, message in
            if isSuccess {
                self.activityIndicatorVisibility(isVisible: true)
                self.loginViewModel.apiForGetLoginData(loginDetail: LoginRequestModel(email: email, password: password)) { [weak self] errorResponse in
                    guard let self = self else {
                        return
                    }
                    self.activityIndicatorVisibility(isVisible: false)
                    if !errorResponse.isEmpty {
                        self.showAlert(strMessage: errorResponse, strActionTitle: CommonString.keyOk)
                    } else {
                        self.loginViewModel.passValueToNextAccountScreen(controllerMain: self)
                    }
                }
                self.activityIndicatorVisibility(isVisible: false)
            } else {
                self.activityIndicatorVisibility(isVisible: false)
                self.showAlert(strMessage: message, strActionTitle: CommonString.keyOk)
            }
        }
    }
    
    func activityIndicatorVisibility(isVisible: Bool) {
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                self.activityIndicator.style = .large
            } else {
                self.activityIndicator.style = .gray
            }
            self.activityIndicator.isHidden = !isVisible
            if isVisible {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @IBAction func closeButtonTap(_ sender: UIButton) {
        self.pop()
    }
    
}

extension LoginViewController {
    
    func configUI() {
        textFieldEmail.label.text = LoginScreenLocalizeString.keyEmail
        textFieldEmail.placeholder = LoginScreenLocalizeString.keyEmail
        textFieldPassword.label.text = LoginScreenLocalizeString.keyPassword
        textFieldPassword.placeholder = LoginScreenLocalizeString.keyPassword
        textFieldEmail.layer.borderColor = JetDevHomeworkTheme.textFieldBorderColor.cgColor
        textFieldEmail.setOutlineColor(JetDevHomeworkTheme.textFieldBorderColor, for: .editing)
        textFieldEmail.setOutlineColor(JetDevHomeworkTheme.textFieldBorderColor, for: .disabled)
        textFieldEmail.setOutlineColor(JetDevHomeworkTheme.textFieldBorderColor, for: .normal)
        textFieldPassword.setOutlineColor(JetDevHomeworkTheme.textFieldBorderColor, for: .editing)
        textFieldPassword.setOutlineColor(JetDevHomeworkTheme.textFieldBorderColor, for: .disabled)
        textFieldPassword.setOutlineColor(JetDevHomeworkTheme.textFieldBorderColor, for: .normal)
        btnLogin.setTitleColor(JetDevHomeworkTheme.buttonTextColor, for: .normal)
        self.isLoginButtonEnable = false
        btnLogin.titleLabel?.font = UIFont.latoSemiBoldFont(size: 18)
        btnLogin.layer.cornerRadius = 5
        btnLogin.clipsToBounds = true
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
        btnLogin.titleLabel?.textAlignment = .left
        btnLogin.setAttributedTitle( NSMutableAttributedString(string: LoginScreenLocalizeString.keyLogin, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
    }
}
