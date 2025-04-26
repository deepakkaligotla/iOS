//
//  ViewController.swift
//  Test2
//
//  Created by Deepak Kaligotla on 26/04/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var continentCollectionView: UICollectionView!
    var url: URL?
    var urlRequest: URLRequest?
    var urlSession: URLSession?
    var continents: [Continent] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        fetchData()
    }
    
    func registerCollectionView() {
        let nib = UINib(nibName: "ContinentCollectionViewCell", bundle: nil)
        self.continentCollectionView.register(nib, forCellWithReuseIdentifier: "ContinentCell")
        self.continentCollectionView.delegate = self
        self.continentCollectionView.dataSource = self
    }

    func fetchData() {
        url = URL(string: Constants.urlString)
        urlRequest = URLRequest(url: url!)
        urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession?.dataTask(with: urlRequest!) { data, response, error in
            let apiResponses = try! JSONSerialization.jsonObject(with: data!) as! [[String: Any]]
            apiResponses.forEach { response in
                let continent = Continent(
                    code: response["code"] as! String,
                    name: response["name"] as! String,
                    areaSqKm: response["areaSqKm"] as! Int,
                    population: response["population"] as! Int,
                    lines: response["lines"] as! [String],
                    countries: response["countries"] as! Int,
                    oceans: response["oceans"] as! [String],
                    developedCountries: response["developedCountries"] as! [String])
                self.continents.append(continent)
            }
            DispatchQueue.main.async {
                self.continentCollectionView.reloadData()
            }
        }
        dataTask?.resume()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.continents.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContinentCell", for: indexPath) as! ContinentCollectionViewCell
        cell.code.text = self.continents[indexPath.row].code
        cell.name.text = self.continents[indexPath.row].name
        cell.areaSqKm.text = "\(self.continents[indexPath.row].areaSqKm)"
        cell.population.text = "\(self.continents[indexPath.row].population)"
        cell.lines.text = "\(self.continents[indexPath.row].lines)"
        cell.countries.text = "\(self.continents[indexPath.row].countries)"
        cell.oceans.text = "\(self.continents[indexPath.row].oceans)"
        cell.developedCountries.text = "\(self.continents[indexPath.row].developedCountries)"
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(identifier: "ContinentDetailsViewController") as! ContinentDetailsViewController
        detailsVC.selectedContinent = self.continents[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: (collectionView.frame.width-10)/2,
            height: ((collectionView.frame.width-10)/2)*1.5)
    }
}
