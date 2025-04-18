//
//  ItemViewController.swift
//  NestedTableNCollection
//
//  Created by Deepak Kaligotla on 26/03/25.
//

import UIKit

class ItemViewController: UIViewController {
    var selectedItem: Item?
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDuration: UILabel!
    @IBOutlet weak var itemDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemDescription.isEditable = false
        if let item = selectedItem {
            itemName.text = item.itemName
            itemImage.image = UIImage(named: item.itemImage)
            itemDuration.text = formatDuration(item.itemDuration)
            itemDescription.text = item.itemDescription
        }
    }
    
    func formatDuration(_ minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        return String(format: "%02dh:%02dm", hours, mins)
    }
}
