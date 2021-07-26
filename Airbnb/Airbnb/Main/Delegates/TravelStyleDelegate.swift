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
        return CGSize(width: CellHeight.travelStyle.rawValue,
                      height: CellHeight.travelStyle.rawValue + 30)
    }
}

class TravelStyleDataSource: NSObject, UICollectionViewDataSource {
    var data: [TravelStyle] = []
    
    override init() {
        super.init()
        getData()
    }
    
    private func getData() {
        guard
            let path = Bundle.main.path(forResource: "style", ofType: "json"),
            let jsonString = try? String(contentsOfFile: path),
            let data = jsonString.data(using: .utf8) else {
            return
        }
        do {
            self.data = try JSONDecoder().decode([TravelStyle].self, from: data)
        } catch {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelStyleCell.identifier, for: indexPath) as! TravelStyleCell
        cell.setup(data: data[indexPath.item])
        return cell
    }
}


struct TravelStyle: Decodable {
    let image: String
    let description: String
}
