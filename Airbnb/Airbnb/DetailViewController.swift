//
//  DetailViewController.swift
//  Airbnb
//
//  Created by Ador on 2021/07/14.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        
        imageCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)

        addNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addNavigationBar() {
        guard let navigationBar = Bundle.main.loadNibNamed("NavigationBar", owner: nil, options: nil)?.first as? NavigationBar else {
            return
        }
        navigationBar.coordinator = coordinator
        navigationBar.frame = CGRect(x: 0, y: 34, width: view.frame.width, height: 100)
        view.addSubview(navigationBar)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath)
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.width, height: view.width)
    }
}
