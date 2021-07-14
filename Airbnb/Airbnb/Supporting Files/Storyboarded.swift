//
//  Storyboarded.swift
//  Airbnb
//
//  Created by Ador on 2021/07/15.
//

import UIKit

protocol Storyboarded {
    static func instantiate(_ name: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ name: String = "Main") -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: id) as? Self else {
            fatalError()
        }
        return viewController
    }
}
