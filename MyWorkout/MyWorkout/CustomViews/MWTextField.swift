//
//  MWTextField.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

final class MWTextField: UITextField {
    private let _padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    init(placeholder: String) {
        super.init(frame: .zero)
        _configure(placeholder)
    }
    
    private func _configure(_ placeholder: String) {
        self.textColor = .label
        self.textAlignment = .left
        self.font = .preferredFont(forTextStyle: .title3)
        self.adjustsFontSizeToFitWidth = true
        self.minimumFontSize = 12
        self.autocorrectionType = .no
        self.returnKeyType = .go
        self.placeholder = placeholder
    }
    
    func createTFLineGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = .init(x: 0, y: self.bounds.height + 10, width: self.bounds.width, height: 1.4)
        gradient.colors = [UIColor.Theme.blue.cgColor, UIColor.Theme.purple.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer()}
        self.layer.addSublayer(gradient)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: _padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: _padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: _padding)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
