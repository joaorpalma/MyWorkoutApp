//
//  BaseViewController.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class BaseViewController<TViewModel: ViewModel>: UIViewController {
    var parameterData: Any?

    private(set) var viewModel: TViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        _setViewConfigurations()
        _instantiateViewModel()
    }

    private func _setViewConfigurations() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .systemBackground
    }
    
    private func _instantiateViewModel() {
        let viewM: TViewModel = DiContainer.resolve()

        if let data = parameterData {
            viewM.prepare(dataObject: data)
        }

        viewModel = viewM
        viewModel?.initialize()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.appearing()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.disappearing()
    }
}
