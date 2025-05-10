//
//  ViewController.swift
//  ContainerViewDemo
//
//  Created by Deepak Kaligotla on 06/05/25.
//

import UIKit

class ViewController: UIViewController {
    var homeCollectionVC: HomeCollectionVC?
    var homeTableVC: HomeTableVC?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let collectionVC = segue.destination as? HomeCollectionVC {
            self.homeCollectionVC = collectionVC
            self.homeCollectionVC?.delegate = self
        } else if let tableVC = segue.destination as? HomeTableVC {
            self.homeTableVC = tableVC
        }
    }
}

extension ViewController: HomeCollectionVCDelegate {
    func didSelectPhotos(_ photos: [Photo]) {
        self.homeTableVC?.updatePhotos(photos)
    }
}
