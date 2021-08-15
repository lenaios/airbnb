//
//  MainViewModel.swift
//  Airbnb
//
//  Created by Ador on 2021/08/15.
//

import Foundation

class MainViewModel {
  
  let repositoryService: RepositoryService
  
  var cities: Box<[City]>?
  var styles: Box<[TravelStyle]>?
  
  init(repositoryService: RepositoryService = RepositoryService(networkManager: MockNetworkManager())) {
    self.repositoryService = repositoryService
  }
  
  func load() {
    repositoryService.fetch { data in
      self.cities = Box(data)
    }
    
    repositoryService.fetchStyle { data in
      self.styles = Box(data)
    }
  }
}
