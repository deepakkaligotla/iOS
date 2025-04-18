//
//  TableViewCell.swift
//  NestedTableNCollection
//
//  Created by Deepak Kaligotla on 26/03/25.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func didSelectItem(_ item: Item)
}

class TableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    private var itemsInSection: [Item] = []
    weak var delegate: TableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
        registerXibFile()
    }

    private func initViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func registerXibFile() {
        let uiNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(uiNib, forCellWithReuseIdentifier: "CVCell")
    }

    func configure(with items: [Item]) {
        self.itemsInSection = items
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsInSection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CollectionViewCell
        let item = itemsInSection[indexPath.row]
        cell.imgView.image = UIImage(named: item.itemImage)
        cell.itemTitle.text = item.itemName
        return cell
    }
}

extension TableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.frame.width / 3) - 10),
                      height: ((collectionView.frame.width / 4) - 10) * 1.5)
    }
}

extension TableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(itemsInSection[indexPath.row])
    }
}
