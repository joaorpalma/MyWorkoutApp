//
//  MWSelectView.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

final class MWSelectView: UIView {
    private let _selectView = UIView()
    private let _titleLabel = UILabel(text: "", font: .systemFont(ofSize: 18, weight: .light), textColor: UIColor.label, textAlignment: .center, numberOfLines: 1)
    
    private let _blueSelectView = UIView()
    
    init(title: String) {
        super.init(frame: .zero)
        _configure(title)
    }
    
    private func _configure(_ title: String) {
        _titleLabel.text = title
        
        _selectView.withSize(CGSize(width: 26, height: 26))
        _selectView.layer.cornerRadius = 13
        _selectView.layer.borderWidth = 1
        _selectView.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        _blueSelectView.withSize(CGSize(width: 16, height: 16))
        _blueSelectView.backgroundColor = UIColor.Theme.blue
        _blueSelectView.layer.cornerRadius = 8
        _blueSelectView.isHidden = true
        
        _selectView.addSubview(_blueSelectView)
        _blueSelectView.centerXTo(_selectView.centerXAnchor)
        _blueSelectView.centerYTo(_selectView.centerYAnchor)
        
        self.hstack(
            _selectView,
            _titleLabel,
            spacing: 15
        )
    }
    
    func select() {
        _blueSelectView.isHidden = false
    }
    
    func unselect() {
        _blueSelectView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
