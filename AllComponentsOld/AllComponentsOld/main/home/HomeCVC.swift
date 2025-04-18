//
//  HomeTVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 05/05/24.
//

import Foundation
import UIKit

class HomeCVSH: UICollectionReusableView {
    @IBOutlet weak var homeSection: UILabel!
    
    func setup(with category: UICategory) {
        self.homeSection.text = category.name
    }
}

class HomeCVC: UICollectionViewCell {
    @IBOutlet weak var homeUIBtn: UILabel!
    
    func setup(with component: UIComponent) {
        self.homeUIBtn.text = component.name
    }
}
