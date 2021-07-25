//
//  MainCollectionViewCell.swift
//  Airbnb
//
//  Created by Ador on 2021/07/13.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    private let headerView: UILabel = {
        let label = UILabel()
        label.text = "가까운 여행지"
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(headerView)
        contentView.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.addSubview(headerView)
        contentView.addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerView.frame = CGRect(x: 10, y: 0, width: contentView.width - 20, height: 74)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func register(_ cell: UICollectionViewCell.Type) {
        collectionView.register(cell.self, forCellWithReuseIdentifier: cell.identifier)
    }
    
    func setup(dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
    
    func setup(delegate: UICollectionViewDelegateFlowLayout) {
        collectionView.delegate = delegate
    }
}
