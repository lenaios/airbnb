//
//  ViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/13.
//

import UIKit

class MainViewController: UIViewController, Storyboarded {
  
  enum Section: String, CaseIterable {
    case nearbyDestinations = "가까운 여행지 둘러보기"
    case travelStyles = "어디에서나, 여행은 살아보는거야!"
  }
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private let padding: CGFloat = 10
  
  private let viewModel: MainViewModel = MainViewModel()
  
  weak var coordinator: MainCoordinator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    
    viewModel.cities?.bind { [weak self] _ in
      self?.collectionView.reloadData()
    }
    
    viewModel.load()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  private func setupCollectionView() {
    collectionView.register(NearbyDestinationCell.nib(), forCellWithReuseIdentifier: NearbyDestinationCell.identifier)
    collectionView.register(TravelStyleCell.self, forCellWithReuseIdentifier: TravelStyleCell.identifier)
    collectionView.register(MainCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainCollectionViewHeader.identifier)
    collectionView.setCollectionViewLayout(generateLayout(), animated: false)
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  func generateLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let sectionLayoutKind = Section.allCases[sectionIndex]
      switch sectionLayoutKind {
      case .nearbyDestinations: return self.nearbyDestinationLayout()
      case .travelStyles: return self.travelStylesLayout()
      }
    }
    return layout
  }
  
  private func nearbyDestinationLayout() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = .init(top: 0, leading: 0, bottom: padding, trailing: padding)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.6),
      heightDimension: .fractionalWidth(0.4))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
    
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(44))
    let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
    section.boundarySupplementaryItems = [headerItem]
    section.orthogonalScrollingBehavior = .groupPaging
    
    return section
  }
  
  private func travelStylesLayout() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(1))
    let item  = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: padding)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.6),
      heightDimension: .fractionalWidth(0.6))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(44))
    let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
    section.boundarySupplementaryItems = [headerItem]
    section.orthogonalScrollingBehavior = .continuous
    
    return section
  }
}

extension MainViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Section.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return viewModel.cities?.value?.count ?? 0
    case 1:
      return viewModel.styles?.value?.count ?? 0
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NearbyDestinationCell.identifier, for: indexPath) as! NearbyDestinationCell
      guard let value = viewModel.cities?.value?[indexPath.item] else { return NearbyDestinationCell() }
      cell.image.image = UIImage(named: value.image)
      cell.city.text = value.name
      cell.distance.text = value.distnace
      return cell
    default:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelStyleCell.identifier, for: indexPath) as! TravelStyleCell
      guard let value = viewModel.styles?.value?[indexPath.item] else { return TravelStyleCell() }
      cell.imageView.image = UIImage(named: value.image)
      cell.textLabel.text = value.description
      return cell
    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainCollectionViewHeader.identifier, for: indexPath) as! MainCollectionViewHeader
    header.backgroundColor = .yellow
    header.header.text = Section.allCases[indexPath.section].rawValue
    return header
  }
}

extension MainViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    let vc = SearchViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
}
