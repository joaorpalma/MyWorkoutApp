//
//  RegisterViewController.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class RegisterViewController: FormBaseViewController<RegisterViewModel> {
    private let _topView = MWTopView(title: "Create a new account", subtitle: "Fill out the form and sign up for free.")
    
    private let _emailTextField = MWTextField(placeholder: "")
    private let _passwordTextField = MWTextField(placeholder: "Password")
    
    private let _nextView = MWNextView(title: "Sign up")
    private let _backView = MWBackView(title: "Cancel")
    
    private let _selectMale = MWSelectView(title: "Male")
    private let _selectFemale = MWSelectView(title: "Female")
    private var _selectView: UIView?
    private let _underlineView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _configureView()
    }
    
    private func _configureView() {
        _configureEmailTextField()
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
        ).padTop(70).padLeft(40).padRight(40).padBottom(50)
        
        self.formContainerStackView.addArrangedSubview(view)
    
        _createNavigation()
    }
    
    private func _configureEmailTextField() {
        _emailTextField.text = "joaowd@outlook.com"
        _emailTextField.isEnabled = false
    }
    
    private func _configureSelectView() {
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
        _emailTextField.createGradient()
        _passwordTextField.createGradient()
        _underlineView.createLineGradient()
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
    }
}
