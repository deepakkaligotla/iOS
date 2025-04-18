//
//  ViewController.swift
//  WebServicesDemo4
//
//  Created by Deepak Kaligotla on 07/04/25.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    var urlRequest: URLRequest?
    var urlSession: URLSession?
    var movies: [Movie] = []
    @IBOutlet weak var moviesTableView: UITableView!
    private let reuseIdentifer = "MovieCell"
    var moviesTableViewcCell: MoviesTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSettings()
        registerXib()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    
    func registerXib() {
        let nib = UINib(nibName: "MoviesTableViewCell", bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: reuseIdentifer)
    }
    
    func initSettings() {
        urlRequest = URLRequest(url: URL(string: Constants.moviesURL)!)
        urlSession = URLSession(configuration: .default)
        let dataTask = urlSession?.dataTask(with: urlRequest!) { (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    self.movies = try jsonDecoder.decode([Movie].self, from: data)
                    DispatchQueue.main.async {
                        self.moviesTableView.reloadData()
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }
        dataTask!.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        moviesTableViewcCell = self.moviesTableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! MoviesTableViewCell
        self.moviesTableViewcCell?.posterImage.kf.setImage(with: URL(string: movies[indexPath.row].poster)!, placeholder: UIImage(systemName: "movie.fill"))
        self.moviesTableViewcCell.movieTitle.text = "\(movies[indexPath.row].title)"
        self.moviesTableViewcCell.year.text = "\(movies[indexPath.row].year)"
        self.moviesTableViewcCell.rating.text = "⭐️ \(movies[indexPath.row].rating)/10"
        self.moviesTableViewcCell.language.text = "Language: \(movies[indexPath.row].language)"
        self.moviesTableViewcCell.duration.text = "Duration: \(movies[indexPath.row].runtime)"
        self.moviesTableViewcCell.director.text = "Director: \(movies[indexPath.row].director)"
        self.moviesTableViewcCell.country.text = "Country: \(movies[indexPath.row].country)"
        self.moviesTableViewcCell.production.text = "Production: \(movies[indexPath.row].production)"
        self.moviesTableViewcCell.genre.text = "Genre: "
        movies[indexPath.row].genre.forEach { genre in
            if(movies[indexPath.row].genre.last != genre) {
                self.moviesTableViewcCell.genre.text?.append(genre + ", ")
            } else {
                self.moviesTableViewcCell.genre.text?.append(genre)
            }
        }
        self.moviesTableViewcCell.cast.text = "Cast: "
        movies[indexPath.row].actors.forEach { actor in
            if(movies[indexPath.row].actors.last != actor) {
                self.moviesTableViewcCell.cast.text?.append(actor + ", ")
            } else {
                self.moviesTableViewcCell.cast.text?.append(actor)
            }
        }
        self.moviesTableViewcCell.plot.text = "Plot: \(movies[indexPath.row].plot)"
        self.moviesTableViewcCell.awards.text = "Awards: \(movies[indexPath.row].awards)"
        self.moviesTableViewcCell.boxOffice.text = "BoxOffice Collection: \(movies[indexPath.row].boxOffice)"
        return self.moviesTableViewcCell ?? UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }
}

