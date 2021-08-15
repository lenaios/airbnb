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
  
  func fetch(completion: @escaping ([City]) -> Void) {
    let cities = [City(name: "서울", image: "seoul", distnace: "차로 30분 거리"),
                  City(name: "부산", image: "busan", distnace: "차로 5시간 거리"),
                  City(name: "양양군", image: "yangyang", distnace: "차로 3시간 거리"),
                  City(name: "고성", image: "goseong", distnace: "차로 2시간 거리"),
                  City(name: "전주", image: "jeonju", distnace: "차로 3시간 거리"),
                  City(name: "완주군", image: "wanju", distnace: "차로 3시간 거리"),
                  City(name: "제주시", image: "jeju", distnace: "차로 4시간 거리")]
    completion(cities)
  }
  
  func fetchStyle(completion: @escaping ([TravelStyle]) -> Void) {
    let styles = [TravelStyle(image: "nature", description: "자연 생활을 만끽할 수 있는 숙소"),
                  TravelStyle(image: "special", description: "독특한 공간"),
                  TravelStyle(image: "house", description: "집 전체"),
                  TravelStyle(image: "dog", description: "반려동물 동반 가능")]
    completion(styles)
  }
}
