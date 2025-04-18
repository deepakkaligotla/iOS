//
//  MoviesTableViewCell.swift
//  WebServicesDemo4
//
//  Created by Deepak Kaligotla on 07/04/25.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var production: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var cast: UILabel!
    @IBOutlet weak var plot: UILabel!
    @IBOutlet weak var awards: UILabel!
    @IBOutlet weak var boxOffice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
