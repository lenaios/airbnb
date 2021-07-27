//
//  Accomodation.swift
//  Airbnb
//
//  Created by Ador on 2021/07/26.
//

import Foundation

struct Accomodation: Decodable {
    let id: Int
    let title: String
    let images: [String]
    let price: String
    let wish: Bool
    let rate: Int
    let host: String
    let type: String
    let longitude: Double
    let latitude: Double
    let options: [String]
    let description: String
}
