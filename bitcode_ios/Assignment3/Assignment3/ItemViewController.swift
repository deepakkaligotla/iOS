//
//  ItemViewController.swift
//  Assignment3
//
//  Created by Deepak Kaligotla on 21/03/25.
//

import UIKit

class ItemViewController: UIViewController {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    var itemIDFromVC: Int?
    var item: (itemID: Int, itemType: types, itemName: String, itemDescription: String, itemPrice: Double, itemImage: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {
        if let itemID = itemIDFromVC, let index = items.firstIndex(where: { $0.itemID == itemID }) {
            self.item = items[index]
            itemImageView.image = UIImage(named: item!.itemImage)
            itemName.text = item!.itemName
            itemDescription.text = item!.itemDescription
            itemPrice.text = "₹ \(item!.itemPrice)"
        }
    }
    
}
