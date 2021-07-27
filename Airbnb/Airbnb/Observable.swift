//
//  Observable.swift
//  Airbnb
//
//  Created by Ador on 2021/07/27.
//

import Foundation

class Observable<T> {
    typealias Completion = (T) -> Void
    private var completion: Completion?
    
    var value: T {
        didSet {
            completion?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(_ completion: @escaping Completion) {
        self.completion = completion
        completion(value)
    }
}
