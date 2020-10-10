//
//  Command.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import Foundation

struct Command {
    private var action: CompletionHandler
    private let canExecuteAction: CanExecuteCompletionHandler

    init(_ action: @escaping CompletionHandler, canExecute: @escaping CanExecuteCompletionHandler = { true }) {
        self.action = action
        self.canExecuteAction = canExecute
    }

    func execute() {
        action()
    }

    func executeIf() {
        if canExecuteAction() {
            action()
        }
    }

    func canExecute() -> Bool {
        return canExecuteAction()
    }
}
