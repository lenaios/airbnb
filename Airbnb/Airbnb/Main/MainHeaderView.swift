//
//  MainHeaderView.swift
//  Airbnb
//
//  Created by Ador on 2021/07/13.
//

import UIKit

class MainHeaderView: UICollectionReusableView {
    
    private let padding: CGFloat = 20
    
    weak var coordinator: MainCoordinator?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "home"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("어디로 여행가세요?", for: .normal)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .systemPink
        button.backgroundColor = .white
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.titleEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        searchButton.frame = CGRect(x: padding, y: 44, width: width - (padding * 2), height: 44)
        searchButton.addTarget(self, action: #selector(touchUpSearch), for: .touchUpInside)
        addSubview(searchButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func touchUpSearch() {
        coordinator?.moveToSearch()
    }
}
