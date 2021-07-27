//
//  NetworkManager.swift
//  Airbnb
//
//  Created by Ador on 2021/07/27.
//

import Foundation

protocol NetworkManager {
    func request<T: Decodable>(completion: @escaping ([T]) -> Void)
}

class MockNetworkManager: NetworkManager {
    func request<T: Decodable>(completion: @escaping ([T]) -> Void) {
        guard
            let path = Bundle.main.path(forResource: "bnb", ofType: "json"),
            let jsonString = try? String(contentsOfFile: path),
            let data = jsonString.data(using: .utf8) else {
            return
        }
        do {
            let data = try JSONDecoder().decode([T].self, from: data)
            completion(data)
        } catch {
            // handle error
        }
    }
}
