//
//  URLRequest+Extensions.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 31/08/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct Resource<T> {
    let url: URL
}

extension URLRequest {
    
    static func loginAPI<T: Decodable>(loginDetails: LoginRequestModel, resource: Resource<T>) -> Observable<T> {
        
        return Observable.just(resource.url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                let json: [String: Any] = [Login.email: loginDetails.email,
                                           Login.password: loginDetails.password]
                
                let jsonData = try? JSONSerialization.data(withJSONObject: json)
                
                request.httpBody = jsonData
                
                return URLSession.shared.rx.response(request: request)
            }.map { response, data -> T in
                if 200..<300 ~= response.statusCode {
                    if T.self == LoginResponse.self {
                        let httpResponse = response
                        let headers = httpResponse.allHeaderFields
                        for (key, value) in headers where (key as? String) == Login.xaccHeader {
                            setValueInUserDefault(key: Login.xaccHeader, value: value)
                        }
                    }
                    return try JSONDecoder().decode(T.self, from: data)
                } else {
                    DispatchQueue.main.async {
                        UIApplication.getTopViewController()?.showAlert(strMessage: "Something went wrong", strActionTitle: "OK")
                    }
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
            }
    }
}
