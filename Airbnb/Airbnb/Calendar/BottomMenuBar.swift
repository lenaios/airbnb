//
//  BottomMenuBar.swift
//  Airbnb
//
//  Created by Ador on 2021/07/23.
//

import UIKit

class BottomMenuBar: UIView {
    
    weak var coordinator: MainCoordinator?
    
    @IBAction func touchUpNext(_ sender: Any) {
        NotificationCenter.default.post(name: .init("selectedDate"), object: self)
        //coordinator?.start()
    }
    
    @IBAction func touchUpSkip(_ sender: Any) {
        coordinator?.moveToResults()
    }
}
