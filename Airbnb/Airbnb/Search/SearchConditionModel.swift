//
//  SearchConditionModel.swift
//  Airbnb
//
//  Created by Ador on 2021/07/26.
//

import Foundation

class SearchConditionModel {
    
    static let shared = SearchConditionModel()
    
    var start: Date?
    var end: Date?
    var guests: Int?
    
}
