//
//  CalendarHeaderView.swift
//  Airbnb
//
//  Created by Ador on 2021/07/23.
//

import UIKit

class CalendarHeaderView: UICollectionReusableView {
  
  private let padding: CGFloat = 20
  
  let yearMonthLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.textColor = .label
    label.font = .systemFont(ofSize: 18, weight: .medium)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    yearMonthLabel.frame = CGRect(x: padding, y: bounds.minY, width: frame.width - (padding * 2), height: bounds.height)
    addSubview(yearMonthLabel)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    yearMonthLabel.text = nil
  }
}
