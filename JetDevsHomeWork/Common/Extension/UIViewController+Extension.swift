//
//  UIViewController+Extension.swift
//  JetDevsHomeWork
//
//  Created by theonetech on 29/08/23.
//
import UIKit
extension UIViewController {
    
    class func instantiateFromNib(bundle: Bundle? = nil) -> Self {
        return self.init(nibName: self.className, bundle: bundle)
    }
    
    public func push(to controller: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: animated)
        }
    }
    
    public func present(to controller: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.present(controller, animated: animated, completion: completion)
        }
    }
    
    public func pop(animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func showAlert(strTitle: String = "Error", strMessage: String, strActionTitle: String) {
        let alertView = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        let btnAction = UIAlertAction(title: strActionTitle, style: .cancel, handler: nil)
        alertView.addAction(btnAction)
        self.present(alertView, animated: true, completion: nil)
    }
}
