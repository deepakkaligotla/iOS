//
//  PhotoCollectionViewCell.swift
//  Assignment07
//
//  Created by Deepak Kaligotla on 11/05/25.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with photo: Photo) {
        titleLabel.text = photo.title
        if let url = URL(string: photo.thumbnailUrl) {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
    }
}
