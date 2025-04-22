//
//  ProductCollectionViewCell.swift
//  Assignment06
//
//  Created by Deepak Kaligotla on 23/04/25.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
