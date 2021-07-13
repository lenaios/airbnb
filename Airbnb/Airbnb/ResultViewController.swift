//
//  ResultViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

class ResultViewController: UIViewController {

    static func instantiate() -> UIViewController {
        return ResultViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
