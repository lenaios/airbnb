//
//  NearbyDestinationDelegate.swift
//  Airbnb
//
//  Created by Ador on 2021/07/13.
//

import UIKit

class NearbyDestinationDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: NearbyDestinationCell.cellSize + 70,
                      height: NearbyDestinationCell.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.show()
    }
}

class NearbyDestinationDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NearbyDestinationCell.identifier, for: indexPath)
        return cell
    }
}
