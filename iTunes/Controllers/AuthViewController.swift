//
//  AuthViewController.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 01.05.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authView: AuthView = {
        AuthView()
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupDelegate()
        configureSignUpButton()
        configureSignInButton()
        registerKeyboardNotification()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    override func loadView() {
        self.view = authView
    }
    
    func configureViewController() {
        self.view.backgroundColor = .white
    }
    
    private func setupDelegate() {
        authView.emailTextField.delegate = self
        authView.passwordTextField.delegate = self
    }
    
    private func configureSignUpButton() {
        authView.signUpButton.addTarget(
            self,
            action: #selector(signUpButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true)
    }
    
    private func configureSignInButton() {
        authView.signInButton.addTarget(
            self,
            action: #selector(signInButtonTapped),
            for: .touchUpInside
        )
    }
        
    @objc private func signInButtonTapped() {
        let mail = authView.emailTextField.text ?? ""
        let password = authView.passwordTextField.text ?? ""
        let user = findUserDataBase(mail: mail)

        if user == nil {
            alert(title: "Error!", message: "User not found")
        } else if user?.password == password {
            let navVC = UINavigationController(rootViewController: AlbumsViewController())
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true)

            guard let activeUser = user else { return }
            DataBase.shared.saveActiveUser(user: activeUser)
        } else {
            alert(title: "Error!", message: "Incorrect password")
        }
        let navVC = UINavigationController(rootViewController: AlbumsViewController())
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }
    
    private func findUserDataBase(mail: String) -> User? {
        let dataBase = DataBase.shared.users
        for user in dataBase where user.email == mail {
            return user
        }
        return nil
    }
}

// MARK: - UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        authView.emailTextField.resignFirstResponder()
        authView.passwordTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Keyboard notification
extension AuthViewController {
    
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
        authView.scrollView.contentOffset = CGPoint(x: 0, y: kbSize.height / 2)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        authView.scrollView.contentOffset = .zero
    }
}
