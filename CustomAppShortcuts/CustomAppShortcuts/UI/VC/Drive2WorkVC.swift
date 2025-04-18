//
//  Drive2Work.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 20/06/24.
//

import UIKit

class Drive2WorkVC: UIViewController {
    @IBOutlet weak var origin: UILabel!
    var selectedOrigin: String? {
        didSet {
            updateOriginLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateOriginLabel() // Ensure label is updated when view loads
    }
    
    func updateOriginLabel() {
        self.origin?.text = selectedOrigin ?? "Origin not selected"
    }
}
