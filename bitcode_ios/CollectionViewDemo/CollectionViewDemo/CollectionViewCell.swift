//
//  CollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by Deepak Kaligotla on 24/03/25.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
