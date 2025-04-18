//
//  ViewController.swift
//  WebServicesDemo7
//
//  Created by Deepak Kaligotla on 14/04/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var productTableView: UITableView!
    var products: [Product] = []
    var url: URL!
    var urlRequest: URLRequest!
    var urlSession: URLSession!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTableView.dataSource = self
        self.productTableView.delegate = self
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.productTableView.register(nib, forCellReuseIdentifier: "ProductCell")
        jsonDecoderForProducts()
    }
    
    func jsonDecoderForProducts() {
        url = URL(string: Constants.allProductsURLString)
        urlRequest = URLRequest(url: url!)
        urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession.dataTask(with: urlRequest!) { (data, response, error) in
            let apiResponseForAllProducts = try! JSONDecoder().decode([Product].self, from: data!)
            self.products = apiResponseForAllProducts
            DispatchQueue.main.async {
                self.productTableView.reloadData()
            }
        }
        dataTask.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250.0
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.productTableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        cell.productTitle.text = self.products[indexPath.row].title
        cell.productDescription.text = self.products[indexPath.row].description
        cell.rating.text = "⭐\(self.products[indexPath.row].rating.rate) \(self.products[indexPath.row].rating.count)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.products.count
    }
}

