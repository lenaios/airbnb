//
//  MainCollectionViewCell.swift
//  Airbnb
//
//  Created by Ador on 2021/07/13.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
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
