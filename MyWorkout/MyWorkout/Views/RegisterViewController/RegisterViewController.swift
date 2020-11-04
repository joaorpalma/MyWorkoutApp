//
//  RegisterViewController.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class RegisterViewController: FormBaseViewController<RegisterViewModel>, UITextFieldDelegate {
    private let _topView = MWTopView(title: "Create a new account", subtitle: "Fill out the form and sign up for free.")
    
    private let _emailTextField = MWTextField(placeholder: "")
    private let _passwordTextField = MWTextField(placeholder: "Password")
    
    private let _nextView = MWNextView(title: "Sign up")
    private let _backView = MWBackView(title: "Cancel")
    
    private let _selectMale = MWSelectView(title: "Male")
    private let _selectFemale = MWSelectView(title: "Female")
    private var _selectView: UIView?
    private let _underlineView = UIView()
    
    private lazy var _activityIndicatorView = self.createActivityIndicatory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _configureView()
    }
    
    private func _configureView() {
        _configureActivityIndicator()
        _configureEmailTextField()
        _configurePasswordTextField()
        _configureSelectView()
        
        let selectGender = UIView().stack(
            _selectView!,
            _underlineView,
            spacing: 15
        )
        
        let formView = UIView().stack(
            _emailTextField,
            _passwordTextField,
            selectGender,
            spacing: 40
        )
        
        let view = UIView().stack(
            _topView,
            formView,
            spacing: 110
        ).padTop(85).padLeft(40).padRight(40).padBottom(25)
        
        self.formContainerStackView.addArrangedSubview(view)
    
        _createNavigation()
    }
    
    private func _configureActivityIndicator() {
        viewModel.isBusy.addObserver(self, completionHandler: weakify { strongSelf in
            if(strongSelf.viewModel.isBusy.value) {
                strongSelf._activityIndicatorView.startAnimating()
            } else {
                strongSelf._activityIndicatorView.stopAnimating()
            }
        })
    }
    
    private func _configureEmailTextField() {
        _emailTextField.text = viewModel.profileEmail
        _emailTextField.isEnabled = false
    }
    
    private func _configurePasswordTextField() {
        self.lowestElement = _passwordTextField
        _passwordTextField.delegate = self
        _passwordTextField.isSecureTextEntry = true
        _passwordTextField.returnKeyType = .done
        _passwordTextField.textContentType = .oneTimeCode
    }
    
    private func _configureSelectView() {
        _selectFemale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(_selectGenderFemale)))
        _selectMale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(_selectGenderMale)))
        
        _selectView = UIView().hstack(
            UIView(),
            _selectFemale,
            _selectMale,
            UIView(),
            distribution: .equalSpacing
        )
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
        _nextView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(_createAccount)))
    }
    
    @objc private func _navigateBack() {
        viewModel.navigateBackCommand.executeIf()
    }
    
    @objc private func _createAccount() {
        viewModel.createAccountCommand.executeIf()
    }
    
    @objc private func _savePassword() {
        viewModel.savePasswordCommand.executeIf(_passwordTextField.text!)
    }
    
    @objc private func _selectGenderFemale() {
        _selectMale.unselect()
        _selectFemale.select()
        viewModel.saveGenderCommand.executeIf(.Female)
    }
    
    @objc private func _selectGenderMale() {
        _selectMale.select()
        _selectFemale.unselect()
        viewModel.saveGenderCommand.executeIf(.Male)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        _savePassword()
        return true
    }
    
    override func handleKeyboardHide() {
        super.handleKeyboardHide()
        _savePassword()
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
        _underlineView.createGradient()
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
    }
}
