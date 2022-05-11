//
//  SignUpViewController.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 01.05.2022.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    private var signUpView: SignUpView = {
        SignUpView()
    }()
    
    private let nameValidType: String.ValidTypes = .name
    private let phoneValidType: String.ValidTypes = .phone
    private let emailValidType: String.ValidTypes = .email
    private let passwordValidType: String.ValidTypes = .password
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupDelegate()
        setupDatePicker()
        configureSignUpButton()
        registerKeyboardNotification()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    override func loadView() {
        self.view = signUpView
    }
    
    private func configureViewController() {
        self.title = "SignUp"
        self.view.backgroundColor = .white
    }
    
    private func setupDelegate() {
        signUpView.firstNameTextField.delegate = self
        signUpView.lastNameTextField.delegate = self
        signUpView.phoneTextField.delegate = self
        signUpView.emailTextField.delegate = self
        signUpView.passwordTextField.delegate = self
    }
    
    private func setupDatePicker() {
        signUpView.datePicker.datePickerMode = .date
        signUpView.datePicker.backgroundColor = .white
        signUpView.datePicker.tintColor = .black
        signUpView.datePicker.layer.borderWidth = 1
        signUpView.datePicker.layer.borderColor = CGColor.init(gray: 0.1, alpha: 0.1)
        signUpView.datePicker.layer.cornerRadius = 6
        signUpView.datePicker.clipsToBounds = true
    }
    
    private func configureSignUpButton() {
        signUpView.signUpButton.addTarget(
            self,
            action: #selector(signUpButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func signUpButtonTapped() {
        let firstNameText = signUpView.firstNameTextField.text ?? ""
        let lastNameText = signUpView.lastNameTextField.text ?? ""
        let phoneText = signUpView.phoneTextField.text ?? ""
        let emailText = signUpView.emailTextField.text ?? ""
        let passwordText = signUpView.passwordTextField.text ?? ""
        
        if firstNameText.isValid(validType: nameValidType) &&
            lastNameText.isValid(validType: nameValidType) &&
            ageIsValid() == true &&
            phoneText.isValid(validType: phoneValidType) &&
            emailText.isValid(validType: emailValidType) &&
            passwordText.isValid(validType: passwordValidType) {
            
            DataBase.shared.saveUser(firstName: firstNameText,
                                     lastName: lastNameText,
                                     age: signUpView.datePicker.date,
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
        let birthDay = signUpView.datePicker.date
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
        signUpView.scrollView.contentOffset = CGPoint(x: 0, y: kbSize.height / 2)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        signUpView.scrollView.contentOffset = .zero
    }
}

// MARK: - UITextFieldDelegate
extension SignUpViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case signUpView.firstNameTextField:
            setTextField(textField: signUpView.firstNameTextField,
                         label: signUpView.firstNameValidLabel,
                         validType: nameValidType,
                         validMessage: "First name is valid",
                         wrongMessage: "Wrong character",
                         string: string,
                         range: range)
            
        case signUpView.lastNameTextField:
            setTextField(textField: signUpView.lastNameTextField,
                         label: signUpView.lastNameValidLabel,
                         validType: nameValidType,
                         validMessage: "Last name is valid",
                         wrongMessage: "Wrong character",
                         string: string,
                         range: range)
            
        case signUpView.phoneTextField:
            setTextField(textField: signUpView.phoneTextField,
                         label: signUpView.phoneValidLabel,
                         validType: phoneValidType,
                         validMessage: "Phone is valid",
                         wrongMessage: "Phone isn't valid",
                         string: string,
                         range: range)
            
        case signUpView.emailTextField:
            setTextField(textField: signUpView.emailTextField,
                         label: signUpView.emailValidLabel,
                         validType: emailValidType,
                         validMessage: "Email is valid",
                         wrongMessage: "Email isn't valid",
                         string: string,
                         range: range)
            
        case signUpView.passwordTextField:
            setTextField(textField: signUpView.passwordTextField,
                         label: signUpView.passwordValidLabel,
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
        signUpView.firstNameTextField.resignFirstResponder()
        signUpView.lastNameTextField.resignFirstResponder()
        signUpView.emailTextField.resignFirstResponder()
        signUpView.passwordTextField.resignFirstResponder()
        return true
    }
}
