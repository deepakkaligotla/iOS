//
//  AlbumCollectionViewCell.swift
//  Assignment07
//
//  Created by Deepak Kaligotla on 11/05/25.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with album: Album) {
        titleLabel.text = album.title
    }
}
