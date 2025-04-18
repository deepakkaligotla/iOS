//
//  CommentTableViewCell.swift
//  WebServicesDemo2
//
//  Created by Deepak Kaligotla on 07/04/25.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
