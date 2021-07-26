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
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 70 + 120,
                      height: 70)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
        coordinator.show()
    }
}

class NearbyDestinationDataSource: NSObject, UICollectionViewDataSource {
    var data: [Region] = []
    
    override init() {
        super.init()
        getData()
    }
    
    private func getData() {
        guard
            let path = Bundle.main.path(forResource: "mock", ofType: "json"),
            let jsonString = try? String(contentsOfFile: path),
            let data = jsonString.data(using: .utf8) else {
            return
        }
        do {
            self.data = try JSONDecoder().decode([Region].self, from: data)
        } catch {
            
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return data.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NearbyDestinationCell.identifier, for: indexPath) as! NearbyDestinationCell
        cell.setup(data: data[indexPath.item])
        return cell
    }
}

struct Region: Decodable {
    let region: String
    let description: String
}

