//
//  BottomMenuBar.swift
//  Airbnb
//
//  Created by Ador on 2021/07/23.
//

import UIKit

protocol BottomNavigationBarDelegate: AnyObject {
  func show()
}

final class BottomNavigationBar: UIView {
  
  weak var delegate: BottomNavigationBarDelegate?
  
  private let padding: CGFloat = 20
  private let stackView = UIStackView()
  
  private let skip: UIButton = {
    let button = UIButton()
    button.setTitle("건너뛰기", for: .normal)
    button.setTitleColor(.systemPink, for: .normal)
    return button
  }()
  
  private let search: UIButton = {
    let button = UIButton()
    button.setTitle("검색", for: .normal)
    button.setTitleColor(.systemPink, for: .normal)
    return button
  }()
  
  weak var coordinator: MainCoordinator?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemGroupedBackground
    stackView.axis = .horizontal
    stackView.distribution = .equalCentering
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(skip)
    stackView.addArrangedSubview(search)
    addSubview(stackView)
    setupActions()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
      stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
      stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -34)
    ])
  }
  
  private func setupActions() {
    skip.addTarget(self, action: #selector(aaa), for: .touchUpInside)
  }
  
  @objc private func aaa() {
    delegate?.show()
  }
}
