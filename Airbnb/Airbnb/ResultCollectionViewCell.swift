//
//  ResultCollectionViewCell.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    private let heart = UIImage(systemName: "heart")
    private let unheart = UIImage(systemName: "heart.fill")
    
    var isHeart: Bool = false
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
    }
    
    @IBAction func touchUpHeart(_ sender: Any) {
        if isHeart {
            heartButton.setImage(heart, for: .normal)
        } else {
            heartButton.setImage(unheart, for: .normal)
        }
        isHeart = !isHeart
    }
}
