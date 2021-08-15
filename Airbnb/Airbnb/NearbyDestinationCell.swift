//
//  NearbyDestinationCell.swift
//  Airbnb
//
//  Created by Ador on 2021/08/15.
//

import UIKit

final class NearbyDestinationCell: UICollectionViewCell {
  
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var city: UILabel!
  @IBOutlet weak var distance: UILabel!
  
  static func nib() -> UINib {
    .init(nibName: NearbyDestinationCell.identifier, bundle: nil)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    image.layer.cornerRadius = 10
    image.clipsToBounds = true
  }
}
