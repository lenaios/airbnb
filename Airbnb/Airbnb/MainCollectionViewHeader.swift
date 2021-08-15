//
//  MainCollectionViewHeader.swift
//  Airbnb
//
//  Created by Ador on 2021/08/15.
//

import UIKit

final class MainCollectionViewHeader: UICollectionReusableView {
  
  let header = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(header)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    header.frame = bounds
  }
}
