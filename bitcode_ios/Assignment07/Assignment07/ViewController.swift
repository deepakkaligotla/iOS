//
//  ViewController.swift
//  Assignment07
//
//  Created by Deepak Kaligotla on 11/05/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!

    private var todosVC: TodosViewController?
    private var commentsVC: CommentsViewController?
    private var albumsVC: AlbumsViewController?
    private var photosVC: PhotosViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        switchToViewController(identifier: "TodosViewController")
    }
    
    @IBAction func todosButtonTapped(_ sender: UIButton) {
        switchToViewController(identifier: "TodosViewController")
    }
    
    @IBAction func commentsButtonTapped(_ sender: UIButton) {
        switchToViewController(identifier: "CommentsViewController")
    }
    
    @IBAction func albumsButtonTapped(_ sender: UIButton) {
        switchToViewController(identifier: "AlbumsViewController")
    }
    
    @IBAction func photosButtonTapped(_ sender: UIButton) {
        switchToViewController(identifier: "PhotosViewController")
    }
    
    private func switchToViewController(identifier: String) {
        for child in children {
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        addChild(viewController)
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
