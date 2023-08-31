//
//  AccountViewController.swift
//  JetDevsHomeWork
//
//  Created by Gary.yao on 2021/10/29.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class AccountViewController: UIViewController {

	@IBOutlet weak var nonLoginView: UIView!
	@IBOutlet weak var loginView: UIView!
	@IBOutlet weak var daysLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var headImageView: UIImageView!
    
    let disposeBag = DisposeBag()
    
    var accountViewModel: AccountViewModel?
    
	override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationController?.navigationBar.isHidden = true
        self.configUI()
    }
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
	@IBAction func loginButtonTap(_ sender: UIButton) {
        let controller = LoginViewController.instantiateFromNib()
        self.push(to: controller)
	}
	
}

extension AccountViewController {
    
    func configUI() {
        self.navigationController?.navigationBar.isHidden = true
        
        guard getValueFromUserDefault(key: UserdefaultKeys.xaccHeader.rawValue) is String else {
            nonLoginView.isHidden = false
            loginView.isHidden = true
            return
        }
        
        guard let userDetail = getCustomUserObjectInUserDefault() else {
            nonLoginView.isHidden = false
            loginView.isHidden = true
            return
        }
        
        self.accountViewModel = AccountViewModel(loginResponse: userDetail)
        
        nonLoginView.isHidden = self.accountViewModel != nil
        loginView.isHidden = self.accountViewModel == nil
        
        guard let urlImage = URL(string: self.accountViewModel?.loginResponse?.data?.user?.profileImage ?? "") else {
            return
        }
        self.headImageView.kf.setImage(with: urlImage)
        
        guard let userName = self.accountViewModel?.loginResponse?.data?.user?.userName else {
            self.nameLabel.text = CommonString.keyNotAvailable
            return
        }
        self.nameLabel.text = userName
        
        guard let dateDays = self.accountViewModel?.loginResponse?.data?.user?.createdAt else {
            self.daysLabel.text = CommonString.keyNotAvailable
            return
        }
        self.daysLabel.text = "\(AccountScreenLocalizedString.keyCreated) \(daysBetweenDates(dateString: dateDays) ?? 0) \(AccountScreenLocalizedString.keyDaysAgo)"
    }
}
