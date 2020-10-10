//
//  CustomUI+Ext.swift
//  MyWorkout
//
//  Created by João Palma on 09/10/2020.
//

import UIKit

struct CustomUIAppearance {
    static func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemGray]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemGray, .shadow: _textShadow()]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]

        UINavigationBar.appearance().standardAppearance.backButtonAppearance = backButtonAppearance
        UINavigationBar.appearance().compactAppearance?.backButtonAppearance = backButtonAppearance
        UINavigationBar.appearance().scrollEdgeAppearance?.backButtonAppearance = backButtonAppearance

        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBackground], for: .normal)
        UIBarButtonItem.appearance().tintColor = UIColor.systemBackground
    }

    static private func _textShadow() -> NSShadow {
        let textShadow = NSShadow()
        textShadow.shadowColor = UIColor.black
        textShadow.shadowBlurRadius = 1.2
        textShadow.shadowOffset = CGSize(width: 0.6, height: 0.6)
        return textShadow
    }
}

extension UIColor {
    struct Theme {
        static var blue = UIColor().fromRGBA(red: 36, green: 187, blue: 200, alpha: 1.0)
        static var purple = UIColor().fromRGBA(red: 94, green: 74, blue: 186, alpha: 1.0)
        static var grey = UIColor().fromRGBA(red: 101, green: 114, blue: 114, alpha: 1.0)
    }
    
    func fromRGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: (red/255.0), green: (green/255.0), blue: (blue/255.0), alpha: alpha)
    }
}
