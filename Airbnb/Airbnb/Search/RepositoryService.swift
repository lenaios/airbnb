//
//  RepositoryService.swift
//  Airbnb
//
//  Created by Ador on 2021/07/27.
//

import Foundation

class RepositoryService {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func search(completion: @escaping ([Accomodation]) -> Void) {
        networkManager.request(completion: completion)
    }
}
