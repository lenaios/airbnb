//
//  CalendarViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/17.
//

import UIKit

final class CalendarViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let menuBar: BottomMenuBar = BottomMenuBar.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "날짜를 선택하세요."
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "지우기", style: .plain, target: self, action: #selector(reset))
        
        setupCollectionView()
        setupDateSelectHandler()
        addMenuBar()

//        NotificationCenter.default.addObserver(self, selector: #selector(setupSearchCondition), name: .init("didTouchUpNext"), object: menuBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    weak var coordinator: Coordinator?
    var viewModel: CalendarViewModel = CalendarViewModel()
}

private extension CalendarViewController {
    @objc func reset() {
        collectionView.indexPathsForSelectedItems?.forEach {
            collectionView.deselectItem(at: $0, animated: false)
        }
        viewModel.deselect()
    }
    
    func setupDateSelectHandler() {
        viewModel.selectHandler = { [weak self] indexPaths in
            guard let self = self else { return }
            let selectedItems = self.collectionView.indexPathsForSelectedItems
            selectedItems?.forEach { self.collectionView.deselectItem(at: $0, animated: false)}
            indexPaths.forEach { self.collectionView.selectItem(at: $0, animated: false, scrollPosition: .centeredHorizontally) }
        }
    }
    
    func setupCollectionView() {
        collectionView.register(
            CalendarHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CalendarHeaderView.identifier
        )
        collectionView.register(
            CalendarDateCollectionViewCell.self,
            forCellWithReuseIdentifier: CalendarDateCollectionViewCell.identifier
        )
        
        collectionView.allowsMultipleSelection = true
    }
    
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

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath)
    -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalendarHeaderView.identifier, for: indexPath) as! CalendarHeaderView
            let year = viewModel.year(at: indexPath)
            let month = viewModel.month(at: indexPath)
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
        let year = viewModel.year(at: indexPath)
        let month = viewModel.month(at: indexPath)
        let dateComponents = DateComponents(year: year, month: month)
        let date = viewModel.calendar.date(from: dateComponents)!
        let daysInMonth = viewModel.calendar.range(of: .day, in: .month, for: date)!.count
        let dayOffset = viewModel.dayOffset(year: year, month: month)
        return daysInMonth + dayOffset
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDateCollectionViewCell.identifier, for: indexPath) as! CalendarDateCollectionViewCell
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
        viewModel.select(at: indexPath)
    }
}
