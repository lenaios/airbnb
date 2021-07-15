//
//  DetailViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

class DetailViewController: UIViewController {

    private let scrollView = UIScrollView()
    
    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCell.self,
                                forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    private let descriptionView = DescriptionView()

    var coordinator: Coordinator?
    
    static func instantiate() -> DetailViewController {
        return DetailViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.frame = CGRect(origin: .zero, size: CGSize(width: view.width, height: view.width))
        scrollView.addSubview(imageCollectionView)
        
        scrollView.addSubview(descriptionView)
        descriptionView.frame = CGRect(x: 0,
                                       y: imageCollectionView.frame.height,
                                       width: view.width,
                                       height: 1000 - view.width)

        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.width, height: 1000)
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)

        addPurchaseView()
        addNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addNavigationBar() {
        guard let navigationBar = Bundle.main.loadNibNamed("NavigationBar", owner: nil, options: nil)?.first as? NavigationBar else {
            return
        }
        navigationBar.coordinator = coordinator
        navigationBar.frame = CGRect(x: 0, y: 34, width: view.frame.width, height: 100)
        view.addSubview(navigationBar)
    }
    
    private func addPurchaseView() {
        guard let purchaseView = Bundle.main.loadNibNamed("PurchaseView", owner: nil, options: nil)?.first as? PurchaseView else {
            return
        }
        purchaseView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(purchaseView)
        NSLayoutConstraint.activate([
            purchaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            purchaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            purchaseView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            purchaseView.heightAnchor.constraint(equalToConstant: 74)
        ])
        
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath)
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.width, height: view.width)
    }
}
