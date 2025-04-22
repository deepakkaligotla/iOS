//
//  PostsViewController.swift
//  Asssignment05
//
//  Created by Deepak Kaligotla on 23/04/25.
//

import UIKit

class PostsViewController: UIViewController {
    var url: URL!
    var urlRequest: URLRequest!
    var urlSession: URLSession!
    var postsApiResponse: PostsApiResponse!
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: PostsTableViewCell.identifier)
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 100
    }

    private func fetchData() {
        guard let url = URL(string: Constants.postsUrlString) else { return }
        let request = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            let jsonObject = try! JSONSerialization.jsonObject(with: data!) as! [String: Any]
            self.postsApiResponse = PostsApiResponse.fromDictionary(jsonObject)
            DispatchQueue.main.async {
                self.postsTableView.reloadData()
            }
        }
        dataTask.resume()
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsApiResponse?.posts.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let post = postsApiResponse?.posts[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.identifier, for: indexPath) as? PostsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: post)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
