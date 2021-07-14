//
//  NavigationBar.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

class NavigationBar: UIView {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backButton.layer.cornerRadius = backButton.frame.width / 2
        shareButton.layer.cornerRadius = shareButton.frame.width / 2
        heartButton.layer.cornerRadius = heartButton.frame.width / 2
    }
}
