//
//  CommentsViewController.swift
//  Assignment07
//
//  Created by Deepak Kaligotla on 11/05/25.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = CommentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        Task {
            await viewModel.fetchComments()
            self.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        let comment = viewModel.comments[indexPath.row]
        cell.textLabel?.text = comment.name
        cell.detailTextLabel?.text = comment.body
        return cell
    }
}
