//
//  RequestObservable.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 29/08/23.
//

import Foundation
import RxSwift
import Alamofire

public class RequestObservable {
    
    private lazy var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession
    
    public init(config: URLSessionConfiguration) {
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }

    public func callAPI<ItemModel: Decodable>(request: URLRequest) -> Observable<ItemModel> {
        return Observable.create { observer in
            let task = self.urlSession.dataTask(with: request) {(data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    do {
                        let data = data ?? Data()
                        if (200...399).contains(statusCode) == true {
                            let objs = try self.jsonDecoder.decode(ItemModel.self, from: data)
                            observer.onNext(objs)
                        } else {
                            if let errorFound = error {
                                observer.onError(errorFound)
                            }
                        }
                    } catch {
                        observer.onError(error)
                    }
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

fileprivate extension Encodable {
    
    var dictionaryValue: [String: Any?]? {
        guard let data = try? JSONEncoder().encode(self), let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
    }
}

class APIClient {
    
    static var shared = APIClient()
    lazy var requestObservable = RequestObservable(config: .default)
    
    func sendPost(loginRequestModel: LoginRequestModel) -> Observable<LoginResponse>? {
        
        guard let urlFound = URL(string: "https://jetdevs.wiremockapi.cloud/login") else {
            return nil
        }
        var request = URLRequest(url: urlFound)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let payloadData = try? JSONSerialization.data(withJSONObject: loginRequestModel.dictionaryValue ?? [:], options: [])
        request.httpBody = payloadData
        return requestObservable.callAPI(request: request)
    }
}
