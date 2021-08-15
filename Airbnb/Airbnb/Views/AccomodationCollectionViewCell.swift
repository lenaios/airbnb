//
//  ResultCollectionViewCell.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

protocol AccomodationCollectionViewCellDelegate: AnyObject {
  func show()
}

final class AccomodationCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imageCollectionView: UICollectionView!
  @IBOutlet weak var rate: UILabel!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var price: UILabel!
  @IBOutlet weak var totalPrice: UILabel!
  
  weak var delegate: AccomodationCollectionViewCellDelegate?
  
  static func nib() -> UINib {
    .init(nibName: AccomodationCollectionViewCell.identifier, bundle: nil)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupCollectionView()
  }
  
  private func setupCollectionView() {
    imageCollectionView.showsVerticalScrollIndicator = false
    imageCollectionView.isPagingEnabled = true
    imageCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
    imageCollectionView.dataSource = self
    imageCollectionView.delegate = self
  }
}

extension AccomodationCollectionViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
    cell.configure()
    return cell
  }
}

extension AccomodationCollectionViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    .init(width: imageCollectionView.frame.width, height: imageCollectionView.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    delegate?.show()
  }
}

final class ImageCell: UICollectionViewCell {
  
  func configure() {
    let imv = UIImageView(image: .init(named: "jeju"))
    imv.frame = contentView.bounds
    imv.layer.cornerRadius = 15
    imv.clipsToBounds = true
    imv.contentMode = .scaleAspectFill
    contentView.addSubview(imv)
  }
}
