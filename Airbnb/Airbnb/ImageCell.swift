//
//  DetailImageCell.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

class ImageCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "wanju.jpg"))
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
