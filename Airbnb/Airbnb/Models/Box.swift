//
//  Observable.swift
//  Airbnb
//
//  Created by Ador on 2021/07/27.
//

import Foundation

final class Box<T> {
  
  typealias Listener = (T?) -> Void
  
  var listener: Listener?
  
  var value: T? {
    didSet {
      listener?(value)
    }
  }
  
  init(_ value: T? = nil) {
    self.value = value
  }
  
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
