//
//  SideMenuVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 03/05/24.
//

import UIKit

class HomeVC: UIViewController, ComponentRouteDelegate {
    @IBOutlet weak var homeCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuVC.delegate = self
        MainVC.delegate = self
        self.homeCV.dataSource = self
        self.homeCV.delegate = self
        if let layout = homeCV.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
            layout.sectionInsetReference = .fromContentInset
        }
    }
    
    func displayViewController(withIdentifier identifier: String) {
        if(identifier != "HomeVC") {
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) {
                if let navigator = self.navigationController {
                    navigator.popViewController(animated: true)
                    navigator.pushViewController(viewController, animated: true)
                } else {
                    print("Error getting navigationController")
                }
            } else {
                print("No viewController found")
            }
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
