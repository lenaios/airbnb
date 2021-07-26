//
//  PurchaseView.swift
//  Airbnb
//
//  Created by Ador on 2021/07/15.
//

import UIKit

class PurchaseView: UIView {
    
    @IBOutlet weak var button: UIButton!
    
    var coordinator: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
    
    @IBAction func reserve() {
        coordinator?()
    }
}
