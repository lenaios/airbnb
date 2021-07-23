//
//  UIView+Extension.swift
//  Airbnb
//
//  Created by Ador on 2021/07/15.
//

import UIKit

extension UIView {
    static let identifier = String(describing: self)
}

extension UIView {
    var width: CGFloat {
        return self.frame.width
    }
}

extension UIView {
    static func loadFromNib<T>() -> T? {
        let name = String(describing: self)
        guard let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T else {
            return nil
        }
        return view
    }
}
