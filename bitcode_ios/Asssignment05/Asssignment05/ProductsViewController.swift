//
//  ViewController.swift
//  Asssignment05
//
//  Created by Deepak Kaligotla on 23/04/25.
//

import UIKit

class ProductsViewController: UIViewController {
    var productsApiResponse: ProductsApiResponse?
    @IBOutlet weak var productsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchData()
    }

    private func setupCollectionView() {
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)

        if let layout = productsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 12
            layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
    }

    private func fetchData() {
        guard let url = URL(string: Constants.productsUrlString) else { return }
        let request = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            let jsonObject = try! JSONSerialization.jsonObject(with: data!) as! [String: Any]
            self.productsApiResponse = ProductsApiResponse.fromDictionary(jsonObject)
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
        }
        dataTask.resume()
    }
}

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsApiResponse?.products.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        if let product = productsApiResponse?.products[indexPath.item] {
            cell.configure(with: product)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.frame.width / 3) - 20),
                      height: ((collectionView.frame.width / 3) - 20) * 2)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let product = productsApiResponse?.products[indexPath.item] {
            let detailVC = ProductDetailViewController(product: product)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
