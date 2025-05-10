//
//  HomeViewController.swift
//  ContainerViewDemo
//
//  Created by Deepak Kaligotla on 06/05/25.
//

import UIKit
import Alamofire
import Kingfisher

class HomeTableVC: UIViewController {
    @IBOutlet weak var homeTableView: UITableView!
    var photoArray: [Photo] = []
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        self.homeTableView.register(nib, forCellReuseIdentifier: "MenuItemCell")
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        fetchAPIData()
    }
    
    func fetchAPIData() {
        Task {
            let data = try! await AF.request(URL(string: "https://fakestoreapi.com/products")!).serializingDecodable([Product].self).value
            products = data
            self.homeTableView.reloadData()
        }
    }
    
    func updatePhotos(_ photos: [Photo]) {
        self.photoArray = photos
        print(photoArray.count)
        self.homeTableView.reloadData()
    }
}

extension HomeTableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsVC.photo = products[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension HomeTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.homeTableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as! HomeTableViewCell
        cell.imageUrl.text = photoArray[indexPath.row].thumbnailUrl
//        cell.photoIV.kf.setImage(with: URL(string: photoArray[indexPath.row].thumbnailUrl)!)
        return cell
    }
}
