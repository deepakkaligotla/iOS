//
//  UserTableViewCell.swift
//  WebServicesAlamofireDemo1
//
//  Created by Deepak Kaligotla on 16/04/25.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
