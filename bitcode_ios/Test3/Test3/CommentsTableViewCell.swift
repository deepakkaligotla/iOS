//
//  CommentsTableViewCell.swift
//  Test3
//
//  Created by Deepak Kaligotla on 05/05/25.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    @IBOutlet weak var postId: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var body: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
