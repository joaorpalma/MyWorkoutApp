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


protocol Weakifiable: class { }

extension Weakifiable {
    func weakify(_ code: @escaping (Self) -> Void) -> () -> Void {
        return { [weak self] in
            guard let self = self else { return }
            
            code(self)
        }
    }
    
    func weakify<T>(_ code: @escaping (T, Self) -> Void) -> (T) -> Void {
        return { [weak self] arg in
            guard let self = self else { return }
            
            code(arg, self)
        }
    }
}

extension NSObject: Weakifiable { }
