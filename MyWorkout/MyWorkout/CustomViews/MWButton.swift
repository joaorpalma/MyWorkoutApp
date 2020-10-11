//
//  MWButton.swift
//  MyWorkout
//
//  Created by João Palma on 11/10/2020.
//

import UIKit

class MWButton: UIButton {
    init(title: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        _configure()
    }
    
    private func _configure() {
        self.layer.cornerRadius = 10
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
