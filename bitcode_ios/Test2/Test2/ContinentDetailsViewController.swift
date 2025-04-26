//
//  ContinentDetailsViewController.swift
//  Test2
//
//  Created by Deepak Kaligotla on 26/04/25.
//

import UIKit

class ContinentDetailsViewController: UIViewController {
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var areaSqKm: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var lines: UILabel!
    @IBOutlet weak var countries: UILabel!
    @IBOutlet weak var oceans: UILabel!
    @IBOutlet weak var developedCountries: UILabel!
    
    var selectedContinent: Continent?
    
    override func viewDidLoad() {
        bindData()
    }
    
    func bindData() {
        self.code.text = selectedContinent?.code
        self.name.text = selectedContinent?.name
        self.areaSqKm.text = "\(selectedContinent!.areaSqKm)"
        self.population.text = "\(selectedContinent!.population)"
        self.lines.text = "\(selectedContinent!.lines)"
        self.countries.text = "\(selectedContinent!.countries)"
        self.oceans.text = "\(selectedContinent!.oceans)"
        self.developedCountries.text = "\(selectedContinent!.developedCountries)"
    }
}
