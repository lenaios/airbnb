//
//  CalendarViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/17.
//

import UIKit

final class CalendarViewController: UIViewController, Storyboarded {
  
  private var collectionView: UICollectionView!
  private let searchConditionView = SearchConditionView()
  
  let viewModel = CalendarViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "날짜를 선택하세요."
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "지우기", style: .plain, target: self, action: #selector(reset))
    
    setupCollectionView()
    setupNavigationBar()
    
    viewModel.checkin.bind { date in
      guard let date = date else {
        self.searchConditionView.startDate.text = nil
        return
      }
      let checkin = self.dateFormatter(date: date)
      self.searchConditionView.startDate.text = checkin
      self.searchConditionView.tableView.reloadData()
    }
    
    viewModel.checkout.bind { date in
      guard let date = date else {
        self.searchConditionView.endDate.text = nil
        return
      }
      let checkout = self.dateFormatter(date: date)
      self.searchConditionView.endDate.text = checkout
      self.searchConditionView.tableView.reloadData()
    }
  }
  
  func dateFormatter(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
}

private extension CalendarViewController {
  
  @objc func reset() {
    viewModel.checkin.value = nil
    viewModel.checkout.value = nil
  }
  
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
    let height: CGFloat = (44 * 3) + 34 + 34 + 10
    searchConditionView.frame = .init(x: 0, y: view.frame.height - height, width: view.frame.width, height: height)
    searchConditionView.delegate = self
    view.addSubview(searchConditionView)
  }
}
extension CalendarViewController: SearchConditionViewDelegate {
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
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 74)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    var totalSpace = flowLayout.minimumInteritemSpacing * CGFloat(6)
    totalSpace += flowLayout.sectionInset.left + flowLayout.sectionInset.right
    let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(7))
    return CGSize(width: size, height: 30)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let date = viewModel.date(at: indexPath) else { return }
    viewModel.selectDate(date: date)
  }
}
