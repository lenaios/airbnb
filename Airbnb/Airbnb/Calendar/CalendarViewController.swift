//
//  CalendarViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/17.
//

import UIKit

class CalendarViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let menuBar: BottomMenuBar = BottomMenuBar.loadFromNib()
    
    private let calendar = Calendar(identifier: .gregorian)
    private let today = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "날짜를 선택하세요."
        
        collectionView.register(
            CalendarHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CalendarHeaderView.identifier
        )
        collectionView.register(
            CalendarDateCollectionViewCell.self,
            forCellWithReuseIdentifier: CalendarDateCollectionViewCell.identifier
        )
        
        addMenuBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    var coordinator: Coordinator?
}

private extension CalendarViewController {
    func addMenuBar() {
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.coordinator = coordinator
        
        view.addSubview(menuBar)
        NSLayoutConstraint.activate([
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
            menuBar.heightAnchor.constraint(equalToConstant: 74)
        ])
    }
}

private extension CalendarViewController {
    func dayOffset(year: Int, month: Int) -> Int {
        let firstOfMonthDateComponents = DateComponents(calendar: calendar, year: year, month: month, day: 1)
        let startOfMonth = calendar.date(from: firstOfMonthDateComponents)!
        let dayOffset = calendar.component(.weekday, from: startOfMonth) - 1
        return dayOffset
    }
    
    func year(at indexPath: IndexPath) -> Int {
        let shiftedDate = calendar.date(byAdding: .month, value: indexPath.section, to: today)!
        let year = calendar.component(.year, from: shiftedDate)
        return year
    }
    
    func month(at indexPath: IndexPath) -> Int {
        let shiftedDate = calendar.date(byAdding: .month, value: indexPath.section, to: today)!
        let month = calendar.component(.month, from: shiftedDate)
        return month
    }
    
    func day(at indexPath: IndexPath) -> Int? {
        let year = self.year(at: indexPath)
        let month = self.month(at: indexPath)
        let day = indexPath.item - dayOffset(year: year, month: month) + 1
        guard day >= 1 else {
            return nil
        }
        return day
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath)
    -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalendarHeaderView.identifier, for: indexPath) as! CalendarHeaderView
            let year = year(at: indexPath)
            let month = month(at: indexPath)
            header.yearMonthLabel.text = "\(year)년 \(month)월"
            return header
        }
        return UICollectionReusableView()
    }
    
    func numberOfSections(
        in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        let indexPath = IndexPath(item: 0, section: section)
        let year = year(at: indexPath)
        let month = month(at: indexPath)
        let dateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: dateComponents)!
        let daysInMonth = calendar.range(of: .day, in: .month, for: date)!.count
        let dayOffset = self.dayOffset(year: year, month: month)
        return daysInMonth + dayOffset
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDateCollectionViewCell.identifier, for: indexPath) as! CalendarDateCollectionViewCell
        let day = day(at: indexPath)
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
        return CGSize(width: view.width, height: 74)
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
