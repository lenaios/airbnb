//
//  ResultViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

class AccomodationListViewController: UIViewController {
  
  private let padding: CGFloat = 15
  
  private var collectionView: UICollectionView!
  
  var viewModel: [SearchResultViewModel] = SearchResultViewModels().viewModels
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "숙소 찾기"
    view.backgroundColor = .systemBackground
    
    setupCollectionView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  
  private func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .systemBackground
    collectionView.register(
      AccomodationCollectionViewCell.nib(),
      forCellWithReuseIdentifier: AccomodationCollectionViewCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    view.addSubview(collectionView)
    self.collectionView = collectionView
  }
}

extension AccomodationListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    .init(width: collectionView.frame.width, height: collectionView.frame.width)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = UIViewController()
    present(vc, animated: true)
  }
}

extension AccomodationListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: AccomodationCollectionViewCell.identifier,
      for: indexPath) as! AccomodationCollectionViewCell
    cell.delegate = self
    return cell
  }
}

extension AccomodationListViewController: AccomodationCollectionViewCellDelegate {
  func show() {
    let vc = UIViewController()
    present(vc, animated: true)
  }
}
