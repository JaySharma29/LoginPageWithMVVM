//
//  LoginViewController.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 29/08/23.
//

import UIKit
import MaterialComponents
import Alamofire
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: MDCOutlinedTextField!
    @IBOutlet weak var textFieldPassword: MDCOutlinedTextField!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    private var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel = LoginViewModel()
        configUI()
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
        let email = (self.textFieldEmail.text ?? "")
        let password = (self.textFieldPassword.text ?? "")
        self.loginViewModel.validateEnteredDetail(email: email, password: password) { isSuccess, message in
            if isSuccess {
                // INdicator chalu krishu!!!!!
                self.loginViewModel.apiForGetLoginData(email: email, password: password)
            } else {
                self.showAlert(strMessage: message, strActionTitle: "OK")
            }
        }
    }
    
    @IBAction func closeButtonTap(_ sender: UIButton) {
        self.pop()
    }
    
//    func postRequestWithParameters(url: String, parameters: [String: Any]) -> Observable<LoginResponse> {
//        return Observable.create { observer in
//            let request = AF.request(url, method: .post, parameters: parameters)
//                .responseJSON { response in
//                    switch response.result {
//                    case .success(let value):
//                        observer.onNext(response)
//                        observer.onCompleted()
//                    case .failure(let error):
//                        observer.onError(error)
//                    }
//                }
//
//            return Disposables.create {
//                request.cancel()
//            }
//        }
//    }
    
    
}

extension LoginViewController {
    
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
}
