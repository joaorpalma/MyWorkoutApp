//
//  MWLogin.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class MWNextView: UIView {
    private let _imageView = UIImageView(image: UIImage(named: "Next-icon"))
    private let _titleLabel = UILabel(text: "", font: .systemFont(ofSize: 20, weight: .light), textColor: UIColor.Theme.blue, textAlignment: .center, numberOfLines: 1)
    
    init(title: String) {
        super.init(frame: .zero)
        _configure(title)
    }
    
    private func _configure(_ title: String) {
        _titleLabel.text = title
        _imageView.withSize(CGSize(width: 24, height: 24))
        
        self.hstack(
            _titleLabel,
            _imageView,
            spacing: 15
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
