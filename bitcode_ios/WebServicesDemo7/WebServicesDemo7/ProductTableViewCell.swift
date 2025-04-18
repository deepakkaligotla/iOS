//
//  ProductTableViewCell.swift
//  WebServicesDemo7
//
//  Created by Deepak Kaligotla on 14/04/25.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
