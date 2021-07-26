//
//  ResultViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    var coordinator: Coordinator?
    
    private let padding: CGFloat = 25
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchResultsCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: SearchResultsCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let mapButton: UIButton = {
        let button = UIButton()
        button.titleEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        button.setImage(UIImage(systemName: "map"), for: .normal)
        button.setTitle("지도", for: .normal)
        button.backgroundColor = .label
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
//    static func instantiate() -> ResultViewController {
//        return ResultViewController()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        view.addSubview(mapButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        mapButton.center = view.center
        mapButton.frame = CGRect(x: view.center.x - 50,
                                 y: view.frame.height - 104,
                                 width: 80,
                                 height: 34)
    }
}

extension SearchResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - (padding * 2), height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        coordinator?.show()
    }
}

extension SearchResultsViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchResultsCollectionViewCell.identifier,
            for: indexPath)
        return cell
    }
}
