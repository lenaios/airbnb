//
//  ResultViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    private let padding: CGFloat = 15
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchResultCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let mapButton: UIButton = {
        let button = UIButton()
        button.titleEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        button.setImage(UIImage(systemName: "map"), for: .normal)
        button.setTitle("지도", for: .normal)
        button.backgroundColor = .label
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    var viewModel: [SearchResultViewModel] = SearchResultViewModels().viewModels
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "숙소 찾기"
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        view.addSubview(mapButton)
        
        let backBarButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backToMain))
        navigationItem.setLeftBarButton(backBarButton, animated: false)
        
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        mapButton.center = view.center
        mapButton.frame = CGRect(x: view.center.x - 50,
                                 y: view.frame.height - 104,
                                 width: 80,
                                 height: 34)
    }
    
    func bindUI() {
        viewModel.enumerated().forEach { (index, model) in
            model.title.bind { title in
                DispatchQueue.main.async {
                    let cell = self.collectionView.cellForItem(
                        at: IndexPath(item: index, section: 0)) as! SearchResultCollectionViewCell
                    cell.title.text = title
                }
            }
        }
    }
    
    @objc func backToMain() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension SearchResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - (padding * 2), height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        coordinator?.start()
    }
}

extension SearchResultsViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchResultCollectionViewCell.identifier,
            for: indexPath) as! SearchResultCollectionViewCell
        return cell
    }
}
