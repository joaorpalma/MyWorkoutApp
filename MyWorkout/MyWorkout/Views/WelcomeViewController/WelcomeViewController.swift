//
//  WelcomeViewController.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class WelcomeViewController: FormBaseViewController<WelcomeViewModel>, UITextFieldDelegate {
    private let _topView = MWTopView(title: "MyWorkout GO", subtitle: "Start by entering your email address.")
    private let _nextView = MWNextView(title: "Next")
    private let _emailTextField = MWTextField(placeholder: "Email address")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _configureView()
        _configureEmailTextField()
    }
    
    private func _configureView() {
        let view = UIView().stack(
            _topView,
            _emailTextField,
            spacing: 120
        ).padTop(60).padLeft(40).padRight(40).padBottom(120)
        
        self.formContainerStackView.addArrangedSubview(view)
        
        _createNavigation()
    }
    
    private func _createNavigation() {
        let bottomView = UIView()
        bottomView.backgroundColor = .systemBackground
        
        bottomView.hstack(
            UIView(),
            _nextView
        ).padTop(5).padLeft(40).padRight(40)
        .padBottom(40 + self.view.safeAreaInsets.bottom)
        
        self.view.addSubview(bottomView)
        
        bottomView.anchor(top: nil, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor)
        
        _createNextViewTapGesture()
    }
    
    private func _createNextViewTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(_checkEmail))
        _nextView.addGestureRecognizer(tapGesture)
    }
    
    private func _configureEmailTextField() {
        _emailTextField.delegate = self
        _emailTextField.keyboardType = .emailAddress
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        _checkEmail()
        return true
    }
    
    @objc private func _checkEmail() {
        self.viewModel.checkEmailCommand.execute(_emailTextField.text!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _createEmailLineGradient()
        super.viewDidAppear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self._createEmailLineGradient()
        }
    }
    
    private func _createEmailLineGradient() {
        _emailTextField.createTFLineGradient()
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
    }
}
