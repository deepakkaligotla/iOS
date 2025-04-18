//
//  CartTableViewCell.swift
//  WebServicesDemo5
//
//  Created by Deepak Kaligotla on 08/04/25.
//

import UIKit
import Kingfisher

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var cartUserId: UILabel!
    @IBOutlet weak var cartTotalProducts: UILabel!
    @IBOutlet weak var cartTotalQuantity: UILabel!
    @IBOutlet weak var cartDiscountedTotal: UILabel!
    @IBOutlet weak var cartTotal: UILabel!
    var products: [Product] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func registerCollectionView() {
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        self.productCollectionView.register(nib, forCellWithReuseIdentifier: "ProductCell")
    }
}

extension CartTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        let product: Product = self.products[indexPath.row]
        productCell.backgroundColor = .gray
        productCell.productImage.kf.setImage(with: URL(string: product.productImageUrl)!)
        productCell.productTitle.text = product.productTitle
        productCell.productPrice.text = "$\(product.productPrice) x \(product.productQuantity)"
        productCell.productTotal.text = "$\(product.productTotal)"
        productCell.productDiscountedPercentage.text = "\(product.productDiscountedPercentage)% Off"
        productCell.productDiscountedTotal.text = "Total = $\(product.productDiscountedTotal)"
        return productCell
    }
}

extension CartTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 10,
                      height: collectionView.frame.height - 10)
    }
}
