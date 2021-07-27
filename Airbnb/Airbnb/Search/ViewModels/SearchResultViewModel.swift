//
//  SearchResultViewModel.swift
//  Airbnb
//
//  Created by Ador on 2021/07/26.
//

import Foundation

class SearchResultViewModel {
    let rate: Observable<String>
    let title: Observable<String>
    var price: Observable<String>
    let isHeart: Observable<Bool>
    
    init(
        rate: Int,
        title: String,
        price: String,
        wish: Bool
        ) {
        self.rate = Observable(value: rate.makeString())
        self.title = Observable(value: title)
        self.price = Observable(value: price)
        self.isHeart = Observable(value: wish)
    }
}

extension Int {
    func makeString() -> String {
        return "\(self)"
    }
}
