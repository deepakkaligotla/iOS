//
//  DetailsViewController.swift
//  ContainerViewDemo
//
//  Created by Deepak Kaligotla on 06/05/25.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var menuItemLabel: UILabel!
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuItemLabel.text = photo?.thumbnailUrl
    }
}
