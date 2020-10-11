//
//  FormBaseViewController.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class FormBaseViewController<TViewModel: ViewModel>: BaseViewController<TViewModel> {
    var formViewAlignment: FormAlignment = .center

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
