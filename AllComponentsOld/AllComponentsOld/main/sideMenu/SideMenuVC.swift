//
//  MainVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 02/05/24.
//

import UIKit
import CoreData

protocol ComponentRouteDelegate {
    func displayViewController(withIdentifier identifier: String)
}

class SideMenuVC: UIViewController {
    @IBOutlet weak var sideMenuTV: UITableView!
    static var delegate: ComponentRouteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .overCurrentContext
        self.sideMenuTV.dataSource = self
        self.sideMenuTV.delegate = self
        self.sideMenuTV.frame.size.width = UIScreen.main.bounds.width/1.5
    }
}
