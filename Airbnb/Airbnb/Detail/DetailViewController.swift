//
//  DetailViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

class DetailViewController: UIViewController {

    private let scrollView = UIScrollView()
    
    private let navigationBar: NavigationBar = NavigationBar.loadFromNib()
    private let descriptionView: DescriptionView = DescriptionView.loadFromNib()
    private let purchaseView: PurchaseView = PurchaseView.loadFromNib()
    
    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCell.self,
                                forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.isPagingEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()

    private lazy var reservationView: UIView = {
        let reservationView: ReservationView = ReservationView.loadFromNib()
        reservationView.frame = CGRect(origin: .zero, size: CGSize(width: 343, height: 589))
        reservationView.center = self.view.center
        reservationView.layer.cornerRadius = 10
        reservationView.clipsToBounds = true
        let dimmedContainerView = UIView(frame: self.view.bounds)
        dimmedContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissReservation)))
        dimmedContainerView.backgroundColor = .black.withAlphaComponent(0.3)
        dimmedContainerView.addSubview(reservationView)
        return dimmedContainerView
    }()
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.frame = CGRect(origin: .zero, size: CGSize(width: view.width, height: view.width))
        scrollView.addSubview(imageCollectionView)

        scrollView.frame = view.bounds
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)

        addPurchaseView()
        addDescriptionView()
        addNavigationBar()
        
        scrollView.contentSize = CGSize(width: view.width, height: view.width + descriptionView.frame.height)
        purchaseView.coordinator = { [weak self] in
            guard let self = self else { return }
            self.view.addSubview(self.reservationView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func dismissReservation() {
        reservationView.removeFromSuperview()
    }
    
    private func addNavigationBar() {
        navigationBar.coordinator = coordinator
        navigationBar.frame = CGRect(x: 0, y: 34, width: view.frame.width, height: 100)
        view.addSubview(navigationBar)
    }
    
    private func addDescriptionView() {
        descriptionView.frame = CGRect(x: 0,
                                       y: imageCollectionView.frame.height,
                                       width: view.width,
                                       height: 300)
        scrollView.addSubview(descriptionView)
    }
    
    private func addPurchaseView() {
        purchaseView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(purchaseView)
        NSLayoutConstraint.activate([
            purchaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            purchaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            purchaseView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
            purchaseView.heightAnchor.constraint(equalToConstant: 74)
        ])
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCell.identifier,
            for: indexPath)
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.width, height: view.width)
    }
}
