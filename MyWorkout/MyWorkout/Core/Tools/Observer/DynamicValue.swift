//
//  DynamicValue.swift
//  MyWorkout
//
//  Created by João Palma on 13/10/2020.
//

import Foundation

final class DynamicValue<T> {
    private var _observers = [String: CompletionHandler]()
    var value : T { didSet { notify() } }
    
    init(_ value: T) {
        self.value = value
    }
    
    func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        _observers[observer.description] = completionHandler
    }
    
    func addAndNotify(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        addObserver(observer, completionHandler: completionHandler)
        notify()
    }
    
    func notify() {
        _observers.forEach({ $0.value() })
    }
    
    deinit {
        _observers.removeAll()
    }
}
