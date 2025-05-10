//
//  ViewController.swift
//  Test3
//
//  Created by Deepak Kaligotla on 05/05/25.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var url: URL?
    var comments = [Comment]()
    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        url = URL(string: "https://dummyjson.com/comments")
        registerXib()
        fetchAPIData()
    }

    func fetchAPIData() {
        AF.request(url!).response { response in
            switch(response.result) {
                case .success(let data):
                    self.comments = try! JSONDecoder().decode(APIResponse.self, from: data!).comments
                    DispatchQueue.main.async {
                        self.commentsTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func registerXib() {
        let nib = UINib(nibName: "CommentsTableViewCell", bundle: nil)
        self.commentsTableView.register(nib, forCellReuseIdentifier: "CommentCell")
        self.commentsTableView.delegate = self
        self.commentsTableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsVC.selectedComment = comments[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.commentsTableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentsTableViewCell
        cell.postId.text = "\(comments[indexPath.row].postId)"
        cell.userName.text = comments[indexPath.row].user.username
        cell.fullName.text = comments[indexPath.row].user.fullName
        cell.body.text = comments[indexPath.row].body
        return cell
    }
}

