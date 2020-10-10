//
//  MWTopView.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class MWTopView: UIView {
    private let _imageView = UIImageView(image: UIImage(named: "Myworkout-logo")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0)))
    private let _titleLabel = UILabel(text: "", font: .systemFont(ofSize: 21, weight: .light), textColor: UIColor.label, textAlignment: .center, numberOfLines: 1)
    private let _subtitleLabel = UILabel(text: "", font: .systemFont(ofSize: 17, weight: .regular), textColor: UIColor.secondaryLabel, textAlignment: .center, numberOfLines: 1)
    
    init(title: String, subtitle: String) {
        super.init(frame: .zero)
        _configure(title, subtitle)
    }
    
    private func _configure(_ title: String, _ subtitle: String) {
        _titleLabel.text = title
        _subtitleLabel.text = subtitle
        _imageView.withSize(CGSize(width: 100, height: 100))
        
        self.stack(
            _imageView,
            _titleLabel,
            _subtitleLabel,
            spacing: 5,
            alignment: .center
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
