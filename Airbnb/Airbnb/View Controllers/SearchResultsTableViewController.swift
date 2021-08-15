//
//  ResultsTableTableViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/26.
//

import UIKit
import MapKit

class SubtitleTableViewCell: UITableViewCell {
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

protocol ResultsTableViewControllerDelegate: NSObject {
  func show()
}

class SearchResultsTableViewController: UITableViewController {
  
  enum Section {
    case main
  }
  
  typealias DataSource = UITableViewDiffableDataSource<Section, MKLocalSearchCompletion>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MKLocalSearchCompletion>
  
  private var searchResults = [MKLocalSearchCompletion]()
  
  private lazy var dataSource = makeDataSource()
  
  weak var delegate: ResultsTableViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "숙소 찾기"
    
    tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: SubtitleTableViewCell.identifier)
    tableView.dataSource = dataSource
  }
}

extension SearchResultsTableViewController {
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 64
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let searchResult = searchResults[indexPath.row]
    let searchRequest = MKLocalSearch.Request(completion: searchResult)
    let search = MKLocalSearch(request: searchRequest)
    search.start { (response, error) in
      guard error == nil else {
        print("location api search error")
        return
      }
      guard
        let placemark = response?.mapItems[0].placemark,
        let cell = tableView.cellForRow(at: indexPath),
        let _ = cell.textLabel?.text
      else {
        return
      }
      print(placemark.coordinate)
    }
    delegate?.show()
  }
}

extension SearchResultsTableViewController {
  func makeDataSource() -> UITableViewDiffableDataSource<Section, MKLocalSearchCompletion> {
    return UITableViewDiffableDataSource(
      tableView: tableView,
      cellProvider: { [weak self] tableView, indexPath, model in
        let cell = tableView.dequeueReusableCell(
          withIdentifier: SubtitleTableViewCell.identifier,
          for: indexPath)
        let searchResult = self?.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult?.title
        cell.detailTextLabel?.text = searchResult?.subtitle
        return cell
      }
    )
  }
  
  func updateSnapshot(animatingChange: Bool = false) {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(searchResults, toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: animatingChange)
  }
}

extension SearchResultsTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    if searchController.searchBar.text == "" {
      searchResults.removeAll()
    }
    updateSnapshot()
  }
}

extension SearchResultsTableViewController: MKLocalSearchCompleterDelegate {
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    searchResults = completer.results
  }
  
  func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    print(error.localizedDescription)
  }
}


