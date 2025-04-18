//
//  SideMenuCVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 03/05/24.
//

import UIKit

class SideMenuTVC: UITableViewCell {
    @IBOutlet weak var sideMenuBtn: UILabel!
    
    func setup(with component: UIComponent) {
        self.sideMenuBtn.text = component.name
    }
}
