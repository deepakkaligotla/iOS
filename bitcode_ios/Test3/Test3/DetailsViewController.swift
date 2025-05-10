//
//  DetailsViewController.swift
//  Test3
//
//  Created by Deepak Kaligotla on 05/05/25.
//

import UIKit

class DetailsViewController: UIViewController {
    var selectedComment: Comment?
    @IBOutlet weak var postId: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var likes: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    func bindData() {
        guard let comment = selectedComment else { return }
        postId.text = "Post ID: \(comment.postId)"
        userId.text = "User ID: \(comment.user.id)"
        userName.text = comment.user.username
        fullName.text = comment.user.fullName
        body.text = comment.body
        likes.text = "👍\(comment.likes)"
    }
}
