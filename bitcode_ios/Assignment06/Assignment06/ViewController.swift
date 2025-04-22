//
//  ViewController.swift
//  Assignment06
//
//  Created by Deepak Kaligotla on 23/04/25.
//

import UIKit

class ViewController: UIViewController {
    var url: URL?
    var urlRequest: URLRequest?
    var urlSession: URLSession?
    @IBOutlet weak var productsCollectionView: UICollectionView!
    var apiResponse: APIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchApi()
        registerCollectionView()
    }
    
    func registerCollectionView() {
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        self.productsCollectionView.register(nib, forCellWithReuseIdentifier: "ProductCell")
    }
    
    func fetchApi() {
        url = URL(string: "https://dummyjson.com/products")
        urlRequest = URLRequest(url: url!)
        urlSession = URLSession(configuration: .default)
        let dataTask = urlSession?.dataTask(with: urlRequest!) { (data, response, error) in
            self.apiResponse = try! JSONDecoder().decode(APIResponse.self, from: data!)
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
        }
        dataTask?.resume()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.apiResponse?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.productsCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        cell.productImage.image = UIImage(named: "placeholder")
        if let url = URL(string: self.apiResponse!.products[indexPath.row].thumbnail) {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                cell.productImage.image = image
            }
        }
        cell.productTitle.text = self.apiResponse!.products[indexPath.row].title
        cell.productPrice.text = "$\(self.apiResponse!.products[indexPath.row].price)"
        cell.productRating.text = "⭐️\(self.apiResponse!.products[indexPath.row].rating)"
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.frame.width / 3) - 10),
                      height: ((collectionView.frame.width / 3) - 10) * 2)
    }
}
