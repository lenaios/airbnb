//
//  MainCollectionViewFlowLayout.swift
//  Airbnb
//
//  Created by Ador on 2021/07/13.
//

import UIKit

class MainCollectionViewFlowLayout: UICollectionViewFlowLayout {
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let layoutAttributes = super.layoutAttributesForElements(in: rect)
    layoutAttributes?.forEach({ attributes in
      if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
        guard let collectionView = collectionView else { return }
        let contentOffsetY = collectionView.contentOffset.y
        if contentOffsetY > 0 { return }
        let width = attributes.frame.width
        let height = attributes.frame.height - contentOffsetY
        attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
      }
    })
    return layoutAttributes
  }
}
