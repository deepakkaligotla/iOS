//
//  ViewController.swift
//  Shinchan
//
//  Created by Deepak Kaligotla on 27/03/23.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet var playerContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setUpPlayerContainerView() {
        playerContainerView = UIView()
        playerContainerView.backgroundColor = .black
        view.addSubview(playerContainerView)
        playerContainerView.translatesAutoresizingMaskIntoConstraints = false
        playerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
            
        if #available(iOS 11.0, *) {
            playerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            playerContainerView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        }
    }
    

}

