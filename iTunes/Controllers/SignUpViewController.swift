//
//  SignUpViewController.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 01.05.2022.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "First name"
        return textField
    }()
    
    private let firstNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Last name"
        return textField
    }()
    
    private let lastNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone"
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private let phoneValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        return textField
    }()
    
    private let emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Sign up", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var elementsStackView = UIStackView()
    private let datePicker = UIDatePicker()
    
    let nameValidType: String.ValidTypes = .name
    let phoneValidType: String.ValidTypes = .phone
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupDelegate()
        setupDatePicker()
        registerKeyboardNotification()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    private func setupViews() {
        title = "SignUp"
        view.addSubview(scrollView)
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
    }
    
    private func setupDelegate() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.tintColor = .black
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = CGColor.init(gray: 0.1, alpha: 0.1)
        datePicker.layer.cornerRadius = 6
        datePicker.clipsToBounds = true
    }
    
    @objc private func signUpButtonTapped() {
        let firstNameText = firstNameTextField.text ?? ""
        let lastNameText = lastNameTextField.text ?? ""
        let phoneText = phoneTextField.text ?? ""
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        
        if firstNameText.isValid(validType: nameValidType) &&
            lastNameText.isValid(validType: nameValidType) &&
            ageIsValid() == true &&
            phoneText.isValid(validType: phoneValidType) &&
            emailText.isValid(validType: emailValidType) &&
            passwordText.isValid(validType: passwordValidType) {
            
            DataBase.shared.saveUser(firstName: firstNameText,
                                     lastName: lastNameText,
                                     age: datePicker.date,
                                     phone: phoneText,
                                     email: emailText,
                                     password: passwordText)
            alert(title: "Good!", message: "Registration complete")
        } else {
            alert(title: "Error!", message: "All fields are filled in, and you must be over 18.")
        }
    }
    
    private func setTextField(textField: UITextField,
                              label: UILabel,
                              validType: String.ValidTypes,
                              validMessage: String,
                              wrongMessage: String,
                              string: String,
                              range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validType) {
            label.text = validMessage
            label.textColor = .green
        } else {
            label.text = wrongMessage
            label.textColor = .red
        }
    }
    
    private func ageIsValid() -> Bool {
        let calendar = NSCalendar.current
        let currentDay = Date()
        let birthDay = datePicker.date
        let age = calendar.dateComponents([.year], from: birthDay, to: currentDay)
        let ageYear = age.year
        guard let ageUser = ageYear else { return  false }
        return ( ageUser < 18 ? false : true)
    }
}

// MARK: - Keyboard notification
extension SignUpViewController {
    
    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentOffset = CGPoint(x: 0, y: kbSize.height / 2)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = .zero
    }
}

// MARK: - UITextFieldDelegate
extension SignUpViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case firstNameTextField:
            setTextField(textField: firstNameTextField,
                         label: firstNameValidLabel,
                         validType: nameValidType,
                         validMessage: "First name is valid",
                         wrongMessage: "Wrong character",
                         string: string,
                         range: range)
            
        case lastNameTextField:
            setTextField(textField: lastNameTextField,
                         label: lastNameValidLabel,
                         validType: nameValidType,
                         validMessage: "Last name is valid",
                         wrongMessage: "Wrong character",
                         string: string,
                         range: range)
            
        case phoneTextField:
            setTextField(textField: phoneTextField,
                         label: phoneValidLabel,
                         validType: phoneValidType,
                         validMessage: "Phone is valid",
                         wrongMessage: "Phone isn't valid",
                         string: string,
                         range: range)
            
        case emailTextField:
            setTextField(textField: emailTextField,
                         label: emailValidLabel,
                         validType: emailValidType,
                         validMessage: "Email is valid",
                         wrongMessage: "Email isn't valid",
                         string: string,
                         range: range)
            
            
        case passwordTextField:
            setTextField(textField: passwordTextField,
                         label: passwordValidLabel,
                         validType: passwordValidType,
                         validMessage: "Password is valid",
                         wrongMessage: "Password isn't valid",
                         string: string,
                         range: range)
            
        default:
            break
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

// MARK: - SetupConstraints
extension SignUpViewController {
    
    private func setupConstraints() {        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
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

