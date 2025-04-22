//
//  ViewController.swift
//  Asssignment04
//
//  Created by Deepak Kaligotla on 22/04/25.
//

import UIKit

class ViewController: UIViewController {
    var url: URL?
    var urlRequest: URLRequest?
    var urlSession: URLSession?
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var albumsTableView: UITableView!
    var comments: [[String: Any]] = [["postId": 0, "id": 0, "name": "", "email": "", "body": ""]]
    var albums: [[String: Any]] = [["userId": 0, "id": 0, "title": ""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentsTableView.delegate = self
        self.commentsTableView.dataSource = self
        self.albumsTableView.delegate = self
        self.albumsTableView.dataSource = self
        jsonDeserializationCommentsApi()
        jsonDeserializationAlbumsApi()
    }
    
    func jsonDeserializationCommentsApi() {
        url = URL(string: Constants.commentsUrlString)
        urlRequest = URLRequest(url: url!)
        urlSession = URLSession(configuration: .default)
        let dataTask = urlSession?.dataTask(with: urlRequest!) { (data, response, error) in
            let apiResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String: Any?]]
            self.comments = apiResponse
            DispatchQueue.main.async {
                self.commentsTableView.reloadData()
            }
        }
        dataTask?.resume()
    }
    
    func jsonDeserializationAlbumsApi() {
        url = URL(string: Constants.albumsUrlString)
        urlRequest = URLRequest(url: url!)
        urlSession = URLSession(configuration: .default)
        let dataTask = urlSession?.dataTask(with: urlRequest!) { (data, response, error) in
            let apiResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String: Any?]]
            self.albums = apiResponse
            DispatchQueue.main.async {
                self.albumsTableView.reloadData()
            }
        }
        dataTask?.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == commentsTableView {
            return comments.count
        } else if tableView == albumsTableView {
            return albums.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if tableView == commentsTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
            cell.textLabel?.text = "Comment Id: \(comments[indexPath.row]["id"] as! Int) - Post Id: \(comments[indexPath.row]["postId"] as! Int)"
            cell.detailTextLabel?.text = "Name: \(comments[indexPath.row]["name"] as! String)\nEmail: \(comments[indexPath.row]["email"] as! String)\nBody: \(comments[indexPath.row]["body"] as! String)"
            cell.detailTextLabel?.numberOfLines = 0
            if let detailLabel = cell.detailTextLabel {
                let heightConstraint = NSLayoutConstraint(item: detailLabel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 120)
                detailLabel.addConstraint(heightConstraint)
            }
        } else if tableView == albumsTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
            cell.textLabel?.text = "Album Id: \(albums[indexPath.row]["id"] as! Int) - User Id: \(albums[indexPath.row]["userId"] as! Int)"
            cell.detailTextLabel?.text = "Title: \(albums[indexPath.row]["title"] as! String)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        if(tableView == commentsTableView) {
            height = 140
        } else if(tableView == albumsTableView) {
            height = 40
        }
        return height
    }
}
