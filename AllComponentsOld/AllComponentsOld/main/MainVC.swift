//
//  MainEmbededVCViewController.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 04/05/24.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var sideMenuVC: SideMenuVC?
    var transparentView: UIView?
    
    @IBAction func sideMenuBtn(_ sender: Any) {
        self.toggleSideMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwipeGesture()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func sideMenuButtonTapped() {
        toggleSideMenu()
    }
    
    func toggleSideMenu() {
        if sideMenuVC == nil {
            addSideMenu()
        } else {
            removeSideMenu()
        }
    }
    
    func addSideMenu() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sideMenuVC = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
        
        if let sideMenuVC = sideMenuVC {
            addChild(sideMenuVC)
            sideMenuVC.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.width/2.5, height: containerView.frame.height)
            
            containerView.addSubview(sideMenuVC.view)
            containerView.bringSubviewToFront(sideMenuVC.view)
            
            sideMenuVC.didMove(toParent: self)
            
            UIView.animate(withDuration: 0.3) {
                sideMenuVC.view.frame.origin.x = 0
            }
        }
    }
    
    func removeSideMenu() {
        if let sideMenuVC = sideMenuVC {
            UIView.animate(withDuration: 0.3, animations: {
                sideMenuVC.view.frame.origin.x = -self.containerView.frame.width
            }) { _ in
                sideMenuVC.willMove(toParent: nil)
                sideMenuVC.view.removeFromSuperview()
                sideMenuVC.removeFromParent()
                self.sideMenuVC = nil
                
                self.transparentView?.removeFromSuperview()
                self.transparentView = nil
            }
        }
    }
    
    @objc func tapToCloseSideMenu() {
        removeSideMenu()
    }
    
    func setupSwipeGesture() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeLeftGesture.direction = .left
        containerView.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeRightGesture.direction = .right
        containerView.addGestureRecognizer(swipeRightGesture)
    }
    
    @objc func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            if sideMenuVC != nil {
                removeSideMenu()
            }
        } else if sender.direction == .right {
            if sideMenuVC == nil {
                addSideMenu()
            }
        }
    }
}
