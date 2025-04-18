//
//  HomeCV.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 05/05/24.
//

import Foundation
import UIKit

extension HomeVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        FetchData().getAllCategories().count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        FetchData().getAllCategories()[section].component!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionVcell = self.homeCV.dequeueReusableCell(withReuseIdentifier: "HomeCVCReusable", for: indexPath) as! HomeCVC
        collectionVcell.setup(with: FetchData().getCategoryComponents(selectedCategory: FetchData().getAllCategories()[indexPath.section].name!)[indexPath.row])
        return collectionVcell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let collectionVSH = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeCVSHReusable", for: indexPath) as! HomeCVSH
        collectionVSH.setup(with: FetchData().getAllCategories()[indexPath.section])
        return collectionVSH
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let identifier = FetchData().getCategoryComponents(selectedCategory: FetchData().getAllCategories()[indexPath.section].name!)[indexPath.row].vcIdentifier {
            self.displayViewController(withIdentifier: identifier)
        }
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 120, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
