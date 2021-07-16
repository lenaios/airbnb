//
//  TravelStyleCell.swift
//  Airbnb
//
//  Created by Ador on 2021/07/13.
//

import UIKit

class TravelStyleCell: UICollectionViewCell {
    static let cellSize: CGFloat = 150
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "wanju.jpg"))
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        imageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
