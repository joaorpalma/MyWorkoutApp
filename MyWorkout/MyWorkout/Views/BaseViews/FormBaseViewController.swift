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
    var lowestElement: UIView!

    lazy var scrollView: UIScrollView = {
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
        self.view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(formContainerStackView)

        if formViewAlignment == .top {
            formContainerStackView.anchor(top: scrollView.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                                          bottom: self.view.safeAreaLayoutGuide.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor)
        } else {
            formContainerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            formContainerStackView.centerInSuperview()
        }
        
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing)))
        _setupKeyboardNotifications()
    }
    
    private func _setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard !_isKeyboardVisible else { return }
        _isKeyboardVisible = true
        
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        
        scrollView.contentInset.bottom = keyboardFrame.height
    
        if formViewAlignment == .center {
            scrollView.contentInset.bottom += self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        }
        
        let distanceToBottom = _distanceFromLowestElementToBottom()
        
        if distanceToBottom > 0 {
            scrollView.contentInset.bottom -= distanceToBottom
        }
        
        scrollView.contentOffset = .init(x: 0, y: scrollView.contentOffset.y + abs(keyboardFrame.height - distanceToBottom))
    }
    
    
    @objc fileprivate func handleKeyboardHide() {
        _isKeyboardVisible = false
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    private func _distanceFromLowestElementToBottom() -> CGFloat {
        if lowestElement != nil {
            guard let frame = lowestElement.superview?.convert(lowestElement.frame, to: view) else { return 0 }
            let distance = view.frame.height - frame.origin.y - (frame.height + 25)
            return distance
        }
        
        return view.frame.height - formContainerStackView.frame.maxY
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
            scrollView.contentSize.height = formContainerStackView.frame.size.height
            scrollView.contentSize.width = formContainerStackView.frame.size.width
        } else {
            scrollView.contentSize.height = view.frame.height
            scrollView.contentSize.width = view.frame.width
        }
    }
}
