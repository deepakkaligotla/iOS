//
//  MyTVCell.swift
//  Assignment3
//
//  Created by Deepak Kaligotla on 18/03/25.
//

import UIKit

class MyTVCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    var onDelete: (() -> Void)?
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        onDelete?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
