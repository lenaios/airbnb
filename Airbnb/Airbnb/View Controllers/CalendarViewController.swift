//
//  CalendarViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/17.
//

import UIKit

final class CalendarViewController: UIViewController, Storyboarded {
  
  private var collectionView: UICollectionView!
  
  var viewModel = CalendarViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "날짜를 선택하세요."
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "지우기", style: .plain, target: self, action: #selector(reset))
    
    setupCollectionView()
    setupNavigationBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
}

private extension CalendarViewController {
  
  @objc func reset() { }
  
  func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(
      CalendarHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: CalendarHeaderView.identifier)
    collectionView.register(
      CalendarDateCollectionViewCell.self,
      forCellWithReuseIdentifier: CalendarDateCollectionViewCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.allowsMultipleSelection = true
    collectionView.backgroundColor = .systemBackground
    collectionView.frame = view.bounds
    view.addSubview(collectionView)
    self.collectionView = collectionView
  }
  
  func setupNavigationBar() {
    let height: CGFloat = 85
    let navigationBar = BottomNavigationBar(
      frame: .init(x: 0, y: view.frame.height - height, width: view.frame.width, height: height))
    navigationBar.delegate = self
    view.addSubview(navigationBar)
  }
}
extension CalendarViewController: BottomNavigationBarDelegate {
  func show() {
    navigationController?.pushViewController(AccomodationListViewController(), animated: true)
  }
}

extension CalendarViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalendarHeaderView.identifier, for: indexPath) as! CalendarHeaderView
      let year = viewModel.year(at: indexPath)
      let month = viewModel.month(at: indexPath)
      header.yearMonthLabel.text = "\(year)년 \(month)월"
      return header
    }
    return UICollectionReusableView()
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 6
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let indexPath = IndexPath(item: 0, section: section)
    let year = viewModel.year(at: indexPath)
    let month = viewModel.month(at: indexPath)
    let dateComponents = DateComponents(year: year, month: month)
    let date = viewModel.calendar.date(from: dateComponents)!
    let daysInMonth = viewModel.calendar.range(of: .day, in: .month, for: date)!.count
    let dayOffset = viewModel.dayOffset(year: year, month: month)
    return daysInMonth + dayOffset
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CalendarDateCollectionViewCell.identifier,
      for: indexPath) as! CalendarDateCollectionViewCell
    let day = viewModel.day(at: indexPath)
    cell.dateLabel.text = day == nil ? nil : "\(day!)"
    return cell
  }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForHeaderInSection section: Int
  ) -> CGSize {
    return CGSize(width: view.frame.width, height: 74)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    var totalSpace = flowLayout.minimumInteritemSpacing * CGFloat(6)
    totalSpace += flowLayout.sectionInset.left + flowLayout.sectionInset.right
    let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(7))
    return CGSize(width: size, height: 30)
  }
}
