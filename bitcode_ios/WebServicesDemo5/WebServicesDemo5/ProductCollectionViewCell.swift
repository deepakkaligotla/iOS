//
//  ProductCollectionViewCell.swift
//  WebServicesDemo5
//
//  Created by Deepak Kaligotla on 08/04/25.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productTotal: UILabel!
    @IBOutlet weak var productDiscountedPercentage: UILabel!
    @IBOutlet weak var productDiscountedTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
