//
//  UsersTableViewCell.swift
//  WebServicesDemo6
//
//  Created by Deepak Kaligotla on 14/04/25.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
