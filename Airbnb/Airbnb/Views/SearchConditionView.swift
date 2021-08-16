//
//  BottomMenuBar.swift
//  Airbnb
//
//  Created by Ador on 2021/07/23.
//

import UIKit

protocol SearchConditionViewDelegate: AnyObject {
  func show()
}

final class SearchConditionView: UIView {
  
  enum Condition: String, CaseIterable {
    case date = "날짜"
    case price = "가격"
    case guest = "게스트"
  }
  
  weak var delegate: SearchConditionViewDelegate?
  
  let startDate = UILabel()
  let endDate = UILabel()
  let price = UILabel()
  let guest = UILabel()
  
  lazy var conditions: [UILabel] = [startDate, endDate, price, guest]
  
  private let padding: CGFloat = 20
  let tableView = UITableView()
  private let navigationBar = UIStackView()
  
  private let skip = UIButton()
  private let forward = UIButton()
  
  weak var coordinator: MainCoordinator?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupActions()
    setupNavigationBar()
    setupTableView()
  }
  
  func setupTableView() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .systemGroupedBackground
    tableView.isScrollEnabled = false
    tableView.rowHeight = 44
    tableView.register(DetailTextTableViewCell.self, forCellReuseIdentifier: DetailTextTableViewCell.identifier)
    tableView.dataSource = self
    addSubview(tableView)
  }
  
  func setupNavigationBar() {
    navigationBar.translatesAutoresizingMaskIntoConstraints = false
    navigationBar.axis = .horizontal
    navigationBar.distribution = .equalCentering
    navigationBar.addArrangedSubview(skip)
    navigationBar.addArrangedSubview(forward)
    addSubview(navigationBar)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    NSLayoutConstraint.activate(
      [tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
       tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
       tableView.topAnchor.constraint(equalTo: self.topAnchor),
       navigationBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
       navigationBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
       navigationBar.topAnchor.constraint(equalTo: tableView.bottomAnchor),
       navigationBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -34),
      ])
  }
  
  private func setupActions() {
    skip.setTitle("건너뛰기", for: .normal)
    skip.setTitleColor(.systemPink, for: .normal)
    skip.addTarget(self, action: #selector(moveToNext), for: .touchUpInside)
    forward.setTitle("검색", for: .normal)
    forward.setTitleColor(.systemPink, for: .normal)
  }
  
  @objc private func moveToNext() {
    delegate?.show()
  }
}

extension SearchConditionView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Condition.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DetailTextTableViewCell.identifier, for: indexPath)
    cell.textLabel?.text = Condition.allCases[indexPath.row].rawValue
    cell.detailTextLabel?.text = conditions[indexPath.row].text
    return cell
  }
}

final class DetailTextTableViewCell: UITableViewCell {
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    selectionStyle = .none
  }
}
