//
//  BottomMenuBar.swift
//  Airbnb
//
//  Created by Ador on 2021/07/23.
//

import UIKit

class BottomMenuBar: UIView {
    
    var coordinator: Coordinator?
    
    @IBAction func touchUpNext(_ sender: Any) {
        NotificationCenter.default.post(name: .init("didTouchUpNext"), object: self)
        coordinator?.show()
    }
}
