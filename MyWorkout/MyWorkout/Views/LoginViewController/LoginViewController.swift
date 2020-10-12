//
//  LoginViewController.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class LoginViewController: FormBaseViewController<LoginViewModel>, UITextFieldDelegate {
    private let _topView = MWTopView(title: "Welcome back", subtitle: "Enter your password to log in.")
    
    private let _emailTextField = MWTextField(placeholder: "")
    private let _passwordTextField = MWTextField(placeholder: "Password")
    
    private let _nextView = MWNextView(title: "Log in")
    private let _backView = MWBackView(title: "Cancel")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _configureView()
    }
    
    private func _configureView() {
        _configureEmailTextField()
        _configurePasswordTextField()

        let formView = UIView().stack(
            _emailTextField,
            _passwordTextField,
            spacing: 40
        )
        
        let view = UIView().stack(
            _topView,
            formView,
            spacing: 110
        ).padTop(70).padLeft(40).padRight(40).padBottom(60)
        
        self.formContainerStackView.addArrangedSubview(view)
    
        _createNavigation()
    }
    
    private func _configureEmailTextField() {
        _emailTextField.text = viewModel.profile.getEmail()
        _emailTextField.isEnabled = false
    }
    
    private func _configurePasswordTextField() {
        self.lowestElement = _passwordTextField
        _passwordTextField.delegate = self
        _passwordTextField.isSecureTextEntry = true
        _passwordTextField.returnKeyType = .go
        _passwordTextField.textContentType = .username
    }
    
    private func _createNavigation() {
        let bottomView = UIView()
        bottomView.backgroundColor = .systemBackground
        
        bottomView.hstack(
            _backView,
            UIView(),
            _nextView
        ).padTop(5).padLeft(40).padRight(40).padBottom(40 + self.view.safeAreaInsets.bottom)
        
        self.view.addSubview(bottomView)
        
        bottomView.anchor(top: nil, leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                          bottom: self.view.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor)
        
        _createNavigationTapGestures()
    }
    
    private func _createNavigationTapGestures() {
        _backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(_navigateBack)))
        _nextView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(_checkPassword)))
    }
    
    @objc private func _navigateBack() {
        viewModel.navigateBackCommand.executeIf()
    }
    
    @objc private func _checkPassword() {
        viewModel.checkPasswordCommand.executeIf(_passwordTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        _checkPassword()
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _createFormLineGradient()
        super.viewDidAppear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self._createFormLineGradient()
        }
    }
    
    private func _createFormLineGradient() {
        _emailTextField.createTFLineGradient()
        _passwordTextField.createTFLineGradient()
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
    }
}
