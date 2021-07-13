//
//  NearbyDestinationCell.swift
//  Airbnb
//
//  Created by Ador on 2021/07/13.
//

import UIKit

class NearbyDestinationCell: UICollectionViewCell {
    static let cellSize: CGFloat = 70
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "jeju.jpg"))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        imageView.frame = CGRect(x: 0, y: 0, width: Self.cellSize, height: Self.cellSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
