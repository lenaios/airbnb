//
//  NearbyDestinationCell.swift
//  Airbnb
//
//  Created by Ador on 2021/07/13.
//

import UIKit

class NearbyDestinationCell: UICollectionViewCell {
    static let height: CGFloat = 70
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
    }
    
    override func layoutSubviews() {
        imageView.frame = CGRect(x: 0, y: 0, width: Self.height, height: Self.height)
        textLabel.frame = CGRect(x: imageView.frame.width + 10, y: 0, width: 90, height: Self.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(data: Region) {
        imageView.image = UIImage(named: data.region)
        textLabel.text = data.description
    }
}
