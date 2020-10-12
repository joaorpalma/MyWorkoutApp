//
//  CustomUI+Ext.swift
//  MyWorkout
//
//  Created by João Palma on 09/10/2020.
//

import UIKit

extension UIViewController {
    func createActivityIndicatory() -> UIActivityIndicatorView {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = view.center
        self.view.addSubview(activityView)
        
        return activityView
    }
}

extension UIColor {
    struct Theme {
        static var blue = UIColor().fromRGBA(red: 36, green: 187, blue: 200, alpha: 1.0)
        static var purple = UIColor().fromRGBA(red: 94, green: 74, blue: 186, alpha: 1.0)
        static var grey = UIColor().fromRGBA(red: 101, green: 114, blue: 114, alpha: 1.0)
        static var green = UIColor().fromRGBA(red: 65, green: 169, blue: 75, alpha: 1.0)
        static var red = UIColor().fromRGBA(red: 229, green: 38, blue: 23, alpha: 1.0)
        static var yellow = UIColor().fromRGBA(red: 237, green: 202, blue: 45, alpha: 1.0)
    }
    
    func fromRGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: (red/255.0), green: (green/255.0), blue: (blue/255.0), alpha: alpha)
    }
}

extension UIView {
    func createGradient(height: CGFloat = 1.4,
        startPosition: CGPoint = CGPoint(x: 0.0, y: 0.5), endPosition: CGPoint = CGPoint(x: 1.0, y: 0.5)) {
        let gradient = CAGradientLayer()
        gradient.frame = .init(x: 0, y: 0, width: self.bounds.width, height: height)
        gradient.colors = [UIColor.Theme.blue.cgColor, UIColor.Theme.purple.cgColor]
        
        gradient.startPoint = startPosition
        gradient.endPoint = endPosition

        self.layer.sublayers?.forEach { $0.removeFromSuperlayer()}
        self.layer.addSublayer(gradient)
    }
}
