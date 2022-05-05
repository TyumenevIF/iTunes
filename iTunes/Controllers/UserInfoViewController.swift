//
//  UserInfoViewController.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 02.05.2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Last name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var stackView = UIStackView()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupModel()
        setupConstraints()
    }
    
    private func setupViews() {
        title = "Active user"
        view.backgroundColor = .white
        
        stackView = UIStackView(arrangedSubviews: [firstNameLabel,
                                                   lastNameLabel,
                                                   ageLabel,
                                                   phoneLabel,
                                                   emailLabel,
                                                   passwordLabel],
                                axis: .vertical,
                                spacing: 10,
                                distribution: .fillProportionally)
        
        view.addSubview(stackView)
    }
    
    private func setupModel() {
        guard let activeUser = DataBase.shared.activeUser else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: activeUser.age)

        firstNameLabel.text = activeUser.firstName
        lastNameLabel.text = activeUser.lastName
        ageLabel.text = dateString
        phoneLabel.text = activeUser.phone
        emailLabel.text = activeUser.email
        passwordLabel.text = activeUser.password
    }
}

// MARK: - SetupConstraints
extension UserInfoViewController {
   
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([            
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
}
