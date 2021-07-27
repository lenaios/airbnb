//
//  SearchResultViewModels.swift
//  Airbnb
//
//  Created by Ador on 2021/07/27.
//

import Foundation

class SearchResultViewModels {

    var viewModels: [SearchResultViewModel] = []
    let service = RepositoryService(networkManager: MockNetworkManager())
    
    init() {
        service.search { data in
            data.forEach { acc in
                let viewModel = SearchResultViewModel.init(
                    rate: acc.rate,
                    title: acc.title,
                    price: acc.price,
                    wish: acc.wish)
                self.viewModels.append(viewModel)
            }
        }
    }
}
