//
//  FormBaseViewController.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class FormBaseViewController<TViewModel: ViewModel>: BaseViewController<TViewModel> {
    var formViewAlignment: FormAlignment = .center
    var _isKeyboardVisible = false

    private lazy var _scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentSize = self.view.frame.size
        scrollView.keyboardDismissMode = .interactive
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    let formContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(_scrollView)
        _scrollView.fillSuperview()
        _scrollView.addSubview(formContainerStackView)

        if formViewAlignment == .top {
            formContainerStackView.anchor(top: _scrollView.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                                          bottom: self.view.safeAreaLayoutGuide.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor)
        } else {
            formContainerStackView.widthAnchor.constraint(equalTo: _scrollView.widthAnchor).isActive = true
            formContainerStackView.centerInSuperview()
        }
        
        _scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _setupKeyboardNotifications()
    }
    
    private func _setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc public func handleKeyboardShow(notification: Notification) {
        guard !_isKeyboardVisible else { return }
        _isKeyboardVisible = true
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardViewEndFrame = self.view.convert(keyboardFrame.cgRectValue, from: self.view.window)
        
        _scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height + 5, right: 0)
        _scrollView.scrollIndicatorInsets = _scrollView.contentInset
        
        if formViewAlignment == .center {
            _scrollView.contentInset.bottom += self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        }
        
        if(self.view.frame.height > formContainerStackView.frame.size.height) {
            _scrollView.contentSize.height = (self.view.frame.height - formContainerStackView.frame.size.height) + keyboardViewEndFrame.height
        } else {
            _scrollView.contentSize.height = formContainerStackView.frame.size.height
        }
    }
    
    @objc public func handleKeyboardHide() {
        _isKeyboardVisible = false
        _scrollView.contentInset = UIEdgeInsets.zero
        _scrollView.contentInset.bottom = 0
        _scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _updateScrollViewSize()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self._updateScrollViewSize()
        }
    }

    private func _updateScrollViewSize() {
        if formContainerStackView.frame.height > view.frame.height {
            _scrollView.contentSize.height = formContainerStackView.frame.size.height
            _scrollView.contentSize.width = formContainerStackView.frame.size.width
        } else {
            _scrollView.contentSize.height = view.frame.height
            _scrollView.contentSize.width = view.frame.width
        }
    }
}
