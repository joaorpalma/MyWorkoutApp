//
//  ProfileViewController.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class ProfileViewController: BaseViewController<ProfileViewModel> {
    private let _tableView = UITableView()
    private let _tableViewDataSource = ProfileDataSource()
    
    private let _profileBackgroundView = UIView()
    private let _gradientView = UIView()
    private let _profileImageView = UIImageView(image: UIImage(named: "profile-photo"), contentMode: .scaleAspectFill)
    private let _profileLabel = UILabel(text: "Profile", font: .systemFont(ofSize: 22), textColor: .white, textAlignment: .center)
    
    private let _profileBackgroundViewRatio: CGFloat = 3
    private var _profileImageHeightConstraint: NSLayoutConstraint?
    private var _profileImageWidthConstraint: NSLayoutConstraint?
    private var _profileBackgroundViewHeightConstraint: NSLayoutConstraint?
    
    private let _logoutButton = MWButton(title: "Log out", backgroundColor: UIColor.Theme.blue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGroupedBackground
        _configureView()
    }
    
    private func _configureView() {
        _configureProfile()
        _configureTableView()
        _configurelogoutButton()
    }
    
    private func _configureProfile() {
        self.view.addSubview(_profileBackgroundView)
        _profileBackgroundView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor)
        
        _profileBackgroundView.addSubview(_gradientView)
        _gradientView.fillSuperview()
        
        let profileView = UIView().stack(
            _profileLabel,
            _profileImageView,
            spacing: 15
        ).padBottom(15)
        
        _profileBackgroundView.addSubview(profileView)
        _profileImageView.layer.masksToBounds = true
        profileView.centerXTo(_profileBackgroundView.centerXAnchor)
        profileView.centerYTo(_profileBackgroundView.centerYAnchor)
        
        _setProfileSize()
    }
    
    private func _setProfileSize() {
        _profileBackgroundViewHeightConstraint = _profileBackgroundView.heightAnchor.constraint(
            equalToConstant: self.view.bounds.height / _profileBackgroundViewRatio)

        _profileImageHeightConstraint = _profileImageView.heightAnchor.constraint(
            equalToConstant: _profileBackgroundViewHeightConstraint!.constant / 2)
        
        _profileImageWidthConstraint = _profileImageView.widthAnchor.constraint(
            equalToConstant: _profileImageHeightConstraint!.constant)
        
        [_profileImageHeightConstraint,
         _profileBackgroundViewHeightConstraint,
         _profileImageWidthConstraint].forEach { $0?.isActive = true }
        
        _profileImageView.layer.cornerRadius = _profileImageHeightConstraint!.constant / 2
    }
    
    private func _configureTableView() {
        self.view.addSubview(_tableView)
        _tableViewDataSource.profileDetails = [
            ProfileDetail(description: "Email", value: "joaowd@outlook.com"),
            ProfileDetail(description: "Gender", value: "Male")
        ]
        
        _tableView.tableFooterView = UIView()
        _tableView.backgroundColor = .systemGroupedBackground
        _tableView.dataSource = _tableViewDataSource
        _tableView.anchor(top: _profileBackgroundView.bottomAnchor, leading: self.view.leadingAnchor,
                          bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
        
        _tableView.reloadData()
    }
    
    private func _configurelogoutButton() {
        self.view.addSubview(_logoutButton)
        _logoutButton.anchor(top: nil, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                             trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 40, right: 40))
        
        _logoutButton.withHeight(50)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _createProfileBackgroundGradient()
        super.viewDidAppear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self._resizeProfileView()
        }
    }
    
    private func _resizeProfileView() {
        _createProfileBackgroundGradient()
        _setProfileConstraints()
    }
    
    private func _setProfileConstraints() {
        _profileBackgroundViewHeightConstraint?.constant = self.view.bounds.height / _profileBackgroundViewRatio
        _profileImageHeightConstraint?.constant = _profileBackgroundViewHeightConstraint!.constant / 2
        _profileImageWidthConstraint?.constant = _profileImageHeightConstraint!.constant
        _profileImageView.layer.cornerRadius = _profileImageHeightConstraint!.constant / 2
    }
    
    private func _createProfileBackgroundGradient() {
        _gradientView.createGradient(height: self.view.bounds.height / _profileBackgroundViewRatio,
                                              startPosition: CGPoint(x: 0, y: 0), endPosition: CGPoint(x: 1, y: 1))
        
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
    }
}
