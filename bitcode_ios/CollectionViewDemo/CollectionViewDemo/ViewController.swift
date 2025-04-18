//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by Deepak Kaligotla on 24/03/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        registerXibFile()
    }
    
    func initViews() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func registerXibFile() {
        let uiNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.collectionView.register(uiNib, forCellWithReuseIdentifier: "CVCell")
        
        let headerNib = UINib(nibName: "SectionHeaderView", bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0
        ? items.filter { $0.itemType == .movie }.count
        : items.filter { $0.itemType == .tvshow }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movies = items.filter { $0.itemType == .movie }
        let tvShows = items.filter { $0.itemType == .tvshow }

        let item = (indexPath.section == 0) ? movies[indexPath.row] : tvShows[indexPath.row]
        let cvCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CollectionViewCell
        cvCell.title.text = item.itemName
        cvCell.imgView.image = UIImage(named: item.itemImage)
        return cvCell
    }
}

//Sections and Headers
extension ViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "SectionHeader",
                for: indexPath
            ) as! SectionHeaderView
            
            header.titleLabel.text = indexPath.section == 0 ? "Movies" : "TV Shows"
            header.titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.frame.width / 3) - 10),
                      height: ((collectionView.frame.width / 3) - 10) * 1.5)
    }
}
