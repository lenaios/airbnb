//
//  TravelStyleCell.swift
//  Airbnb
//
//  Created by Ador on 2021/07/13.
//

import UIKit

class TravelStyleCell: UICollectionViewCell {
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 15
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let textLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
    contentView.addSubview(textLabel)
  }
  
  override func layoutSubviews() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -34),
      textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
      textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
