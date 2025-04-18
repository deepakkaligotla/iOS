//
//  ViewController.swift
//  WebServicesDemo2
//
//  Created by Deepak Kaligotla on 03/04/25.
//


import UIKit

class ViewController: UIViewController {
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var comments: [Comment] = []
    @IBOutlet weak var commentTableView: UITableView!
    var commentTableViewCell: CommentTableViewCell!
    private var reuseIdentifier = "CommentCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSettings()
        jsonSerialization()
        registerTableCell()
    }
    
    func registerTableCell() {
        let xib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        commentTableView.register(xib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func initSettings(){
        commentTableView.dataSource = self
        commentTableView.delegate = self
        url = URL(string: Constants.urlString)
        urlRequest = URLRequest(url: url!)
        urlSession = URLSession(configuration: .default)
    }
    
    func jsonSerialization(){
        let dataTask = urlSession?.dataTask(with: urlRequest!){ data,res,error in
            let jsonResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String: Any]]
            for eachComment in jsonResponse {
                self.comments.append(
                    Comment(
                        postId: eachComment["id"] as! Int,
                        id: eachComment["postId"] as! Int,
                        name: eachComment["name"] as! String,
                        email: eachComment["email"] as! String,
                        body: eachComment["body"] as! String
                    )
                )
            }
            DispatchQueue.main.async {
                self.commentTableView.reloadData()
            }
        }
        dataTask?.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        commentTableViewCell = self.commentTableView?.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CommentTableViewCell
        
        self.commentTableViewCell.idLabel.text = "\(comments[indexPath.row].id)"
        self.commentTableViewCell.nameLabel.text = "\(comments[indexPath.row].name)"
        self.commentTableViewCell.emailLabel.text = "\(comments[indexPath.row].email)"
        self.commentTableViewCell.bodyLabel.text = "\(comments[indexPath.row].body)"
        
        return commentTableViewCell ?? UITableViewCell()
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
