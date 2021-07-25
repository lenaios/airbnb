//
//  ResultCollectionViewCell.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private let heart = UIImage(systemName: "heart")
    private let unheart = UIImage(systemName: "heart.fill")
    
    var isHeart: Bool = false
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCollectionView.register(ImageCell.self,
                                     forCellWithReuseIdentifier: ImageCell.identifier)
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.layer.cornerRadius = 10
        imageCollectionView.clipsToBounds = true
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

extension ResultCollectionViewCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCell.identifier,
            for: indexPath)
        return cell
    }
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.frame.width)
        self.pageControl.currentPage = page
    }
}

extension ResultCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollectionView.frame.width,
                      height: imageCollectionView.frame.height)
    }
}
