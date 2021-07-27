//
//  SearchResultViewModel.swift
//  Airbnb
//
//  Created by Ador on 2021/07/26.
//

import Foundation

protocol NetworkManager {
    func request(completion: @escaping ([Accomodation]) -> Void)
}

class MockNetworkManager: NetworkManager {
    func request(completion: @escaping ([Accomodation]) -> Void) {
        guard
            let path = Bundle.main.path(forResource: "bnb", ofType: "json"),
            let jsonString = try? String(contentsOfFile: path),
            let data = jsonString.data(using: .utf8) else {
            return
        }
        do {
            let data = try JSONDecoder().decode([Accomodation].self, from: data)
            completion(data)
        } catch {
            // handle error
        }
    }
}

class SearchResultsViewModel {

    var results: [SearchResultViewModel] = []
    let service = RepositoryService(networkManager: MockNetworkManager())
    
    init() {
        service.search { data in
            data.forEach { acc in
                let viewModel = SearchResultViewModel.init(
                    rate: acc.rate,
                    title: acc.title,
                    price: acc.price,
                    wish: acc.wish)
                self.results.append(viewModel)
            }
        }
    }
}


class SearchResultViewModel {
    let rate: String
    let title: String
    let price: String
    let isHeart: Bool
    
    init(
        rate: Int,
        title: String,
        price: String,
        wish: Bool
        ) {
        self.rate = rate.makeString()
        self.title = title
        self.price = price + " / 박"
        self.isHeart = wish
    }
}

extension Int {
    func makeString() -> String {
        return "\(self)"
    }
}
