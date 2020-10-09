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
