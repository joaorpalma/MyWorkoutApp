//
//  MwBackView.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class MWBackView: UIView {
    private let _imageView = UIImageView(image: UIImage(named: "Back-icon"))
    private let _titleLabel = UILabel(text: "", font: .systemFont(ofSize: 20, weight: .light), textColor: UIColor.secondaryLabel, textAlignment: .center, numberOfLines: 1)
    
    init(title: String) {
        super.init(frame: .zero)
        _configure(title)
    }
    
    private func _configure(_ title: String) {
        _titleLabel.text = title
        _imageView.withSize(CGSize(width: 24, height: 24))
        
        self.hstack(
            _imageView,
            _titleLabel,
            spacing: 15
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
