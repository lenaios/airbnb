//
//  TravelStyleDelegate.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

class TravelStyleDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: TravelStyleCell.cellSize,
                      height: TravelStyleCell.cellSize)
    }
}

class TravelStyleDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelStyleCell.identifier, for: indexPath)
        return cell
    }
}
