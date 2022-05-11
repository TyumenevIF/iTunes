//
//  SignUpView.swift
//  iTunes_test
//
//  Created by Ilyas Tyumenev on 11.05.2022.
//

import UIKit

class SignUpView: UIView {
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private(set) lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "First name"
        return textField
    }()
    
    private(set) lazy var firstNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Last name"
        return textField
    }()
    
    private(set) lazy var lastNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var ageValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone"
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private(set) lazy var phoneValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        return textField
    }()
    
    private(set) lazy var emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private(set) lazy var passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Sign up", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var elementsStackView = UIStackView()
    let datePicker = UIDatePicker()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        elementsStackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                           firstNameValidLabel,
                                                           lastNameTextField,
                                                           lastNameValidLabel,
                                                           datePicker,
                                                           ageValidLabel,
                                                           phoneTextField,
                                                           phoneValidLabel,
                                                           emailTextField,
                                                           emailValidLabel,
                                                           passwordTextField,
                                                           passwordValidLabel],
                                        axis: .vertical,
                                        spacing: 10,
                                        distribution: .fillProportionally)
        backgroundView.addSubview(registrationLabel)
        backgroundView.addSubview(elementsStackView)
        backgroundView.addSubview(signUpButton)
    
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            
            elementsStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            elementsStackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            elementsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            elementsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            
            registrationLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            registrationLabel.bottomAnchor.constraint(equalTo: elementsStackView.topAnchor, constant: -30),
            
            signUpButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: elementsStackView.bottomAnchor, constant: 30),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signUpButton.leadingAnchor.constraint(equalTo: elementsStackView.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: elementsStackView.trailingAnchor)
        ])
    }
}
