//
//  ContinentCollectionViewCell.swift
//  Test2
//
//  Created by Deepak Kaligotla on 26/04/25.
//

import UIKit

class ContinentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var areaSqKm: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var lines: UILabel!
    @IBOutlet weak var countries: UILabel!
    @IBOutlet weak var oceans: UILabel!
    @IBOutlet weak var developedCountries: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
