//
//  Drive2Home.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 20/06/24.
//

import UIKit

class Back2HomeVC: UIViewController {
    @IBOutlet weak var bookedDetails: UILabel!
    
    var selectedOrigin: String? {
        didSet {
            updateScreenDetails()
        }
    }
    
    var selectedVehicle: String? {
        didSet {
            updateScreenDetails()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScreenDetails()
    }
    
    func updateScreenDetails() {
        self.bookedDetails?.text = "Booked \(selectedVehicle ?? "") from \(selectedOrigin ?? "") to Home."
    }
}
