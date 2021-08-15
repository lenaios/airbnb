//
//  SearchViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/26.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {
  
  private let padding: CGFloat = 10
  private let resultsTableViewController = SearchResultsTableViewController()
  private let searchCompleter = MKLocalSearchCompleter()
  
  weak var coordinator: MainCoordinator?
  
  private lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: resultsTableViewController)
    searchController.searchBar.placeholder = "어디로 여행가세요?"
    searchController.automaticallyShowsCancelButton = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchResultsUpdater = resultsTableViewController
    return searchController
  }()
  
  private var collectionView: UICollectionView!
  
  private func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: 0, right: padding)
    layout.itemSize = .init(width: view.frame.width - (padding * 2), height: 74)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(
      NearbyDestinationCell.nib(), forCellWithReuseIdentifier: NearbyDestinationCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.showsVerticalScrollIndicator = false
    collectionView.backgroundColor = .systemBackground
    collectionView.frame = view.bounds
    view.addSubview(collectionView)
    self.collectionView = collectionView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "숙소 찾기"
    view.backgroundColor = .systemBackground
    //definesPresentationContext = true
    
    setupCollectionView()
    
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    
    searchController.searchBar.delegate = self
    searchCompleter.delegate = resultsTableViewController
    resultsTableViewController.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    let vc = CalendarViewController()
    vc.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: vc, action: nil)
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchCompleter.queryFragment = searchText
  }
}

extension SearchViewController: ResultsTableViewControllerDelegate {
  func show() {
    let vc = CalendarViewController()
    vc.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: vc, action: nil)
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension SearchViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NearbyDestinationCell.identifier, for: indexPath)
    return cell
  }
}
