//
//  ViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var coordinator: Coordinator = MainCoordinator(navigationController: navigationController!)
    
    private lazy var delegates: [UICollectionViewDelegateFlowLayout]
        = [NearbyDestinationDelegate(coordinator: coordinator), TravelStyleDelegate()]
    
    private let dataSources: [UICollectionViewDataSource]
        = [NearbyDestinationDataSource(), TravelStyleDataSource()]
    
    private let cells = [NearbyDestinationCell.self, TravelStyleCell.self]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupCollectionView() {
        collectionView.register(MainHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: MainHeaderView.identifier)
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.contentInsetAdjustmentBehavior = .never
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainHeaderView.identifier, for: indexPath)
        return header
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            let width = view.frame.width
            return CGSize(width: width, height: width + 100)
        }
        return .zero
    }
    
    func numberOfSections(
        in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            fatalError()
        }
        cell.register(cells[indexPath.section])
        cell.setup(delegate: delegates[indexPath.section])
        cell.setup(dataSource: dataSources[indexPath.section])
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width,
                      height: (NearbyDestinationCell.height * 2) + 20 + 10 + 74)
    }
}
