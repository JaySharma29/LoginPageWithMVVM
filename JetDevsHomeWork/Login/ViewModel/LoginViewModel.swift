//
//  LoginViewModel.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 29/08/23.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    var loginResponse: Observable<LoginResponse>?
    
    override init() {
        super.init()
    }
    
    func apiForGetLoginData(loginDetail: LoginRequestModel, completion: @escaping (String) -> Void) {
        guard let url = URL.baseURL() else {
            return
        }
        
        let resource = Resource<LoginResponse>(url: url)
        let result = URLRequest.loginAPI(loginDetails: loginDetail, resource: resource)
            .observeOn(MainScheduler.instance)
        self.loginResponse = result
        self.storeUserDataInLocal()
        
        result.map {$0.errorMessage}
            .subscribe(onNext: { loginResponseErrorMsg in
                if let loginResponseErrorMsg = loginResponseErrorMsg {
                    if loginResponseErrorMsg.isEmpty {
                        if self.loginResponse != nil {
                            completion("")
                        }
                    } else {
                        completion(loginResponseErrorMsg)
                    }
                } else {
                    completion(CommonString.keySomethingWentWrong)
                }
            }).disposed(by: self.disposeBag)
    }

    func storeUserDataInLocal() {
        guard let loginResponse = self.loginResponse else {
            return
        }
        
        loginResponse.map { $0 }
            .subscribe(onNext: { loginObject in
                setCustomUserObjectInUserDefault(loginResponse: loginObject)
                
            }).disposed(by: self.disposeBag)
    }
    
    func validateEnteredDetail(loginDetail: LoginRequestModel, complition: @escaping ((Bool, String) -> Void)) {
        if loginDetail.email == "" || loginDetail.password == "" {
            complition(false, LoginScreenValidationLocalizeString.keyEmailPasswordBlank)
        } else if !isValidEmail(email: loginDetail.email) {
            complition(false, LoginScreenValidationLocalizeString.keyInvalidEmail)
        } else if loginDetail.password.count <= 6 {
            complition(false, LoginScreenValidationLocalizeString.keyPasswordLengthError)
        } else {
            complition(true, "")
        }
    }
 
    func passValueToNextAccountScreen(controllerMain: UIViewController) {
        let controller = AccountViewController.instantiateFromNib()
        controllerMain.push(to: controller)
    }
}
