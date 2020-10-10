//
//  TypeAlias.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import Foundation

typealias CompletionHandler = () -> Void
typealias CompletionHandlerWithParam<T> = (T) -> Void
typealias CanExecuteCompletionHandler = () -> (Bool)

infix operator ??=
func ??= <T>(left: inout T?, right: T) {
    left = left ?? right
}
