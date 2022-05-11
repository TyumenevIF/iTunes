//
//  UserInfoViewController.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 02.05.2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    private var userInfoView: UserInfoView = {
        UserInfoView()
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupModel()
    }
    
    override func loadView() {
        self.view = userInfoView
    }
    
    private func configureViewController() {
        title = "Active user"
        view.backgroundColor = .white
    }
    
    private func setupModel() {
        guard let activeUser = DataBase.shared.activeUser else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: activeUser.age)

        userInfoView.firstNameLabel.text = activeUser.firstName
        userInfoView.lastNameLabel.text = activeUser.lastName
        userInfoView.ageLabel.text = dateString
        userInfoView.phoneLabel.text = activeUser.phone
        userInfoView.emailLabel.text = activeUser.email
        userInfoView.passwordLabel.text = activeUser.password
    }
}
