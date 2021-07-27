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
    
    private let resultsTableViewController = ResultsTableViewController()
    private var searchCompleter = MKLocalSearchCompleter()
    
    private let dataSource = NearbyDestinationDataSource()
    
    var coordinator: Coordinator?
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: resultsTableViewController)
        searchController.searchBar.placeholder = "어디로 여행가세요?"
        searchController.automaticallyShowsCancelButton = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = resultsTableViewController
        return searchController
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NearbyDestinationCell.self,
                                forCellWithReuseIdentifier: NearbyDestinationCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "숙소 찾기"
        view.backgroundColor = .systemBackground
        //definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        
        searchController.searchBar.delegate = self
        searchCompleter.delegate = resultsTableViewController
        resultsTableViewController.delegate = self
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "지우기", style: .plain, target: self, action: #selector(reset))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: view.width - (padding * 2), height: 64)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.show()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}

extension SearchViewController: ResultsTableViewControllerDelegate {
    func show() {
        coordinator?.show()
    }
}
