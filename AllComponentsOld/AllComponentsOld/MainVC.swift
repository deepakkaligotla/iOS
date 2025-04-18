//
//  SplitVCViewController.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 08/05/24.
//

import UIKit

class MainVC: UIViewController {
    var sideMenuVC: SideMenuVC?
    var transparentView: UIView?
    let managedObjectContext =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var delegate: ComponentRouteDelegate?
    
    @IBAction func SideMenuBtn(_ sender: Any) {
        self.toggleSideMenu()
    }
    
    @IBAction func homeBtn(_ sender: Any) {
        MainVC.delegate?.displayViewController(withIdentifier: "HomeVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createItems()
        self.setupSwipeGesture()
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
            transparentView = UIView(frame: UIScreen.main.bounds)
            transparentView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToCloseSideMenu))
            transparentView?.addGestureRecognizer(tapGesture)
            let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
            swipeLeftGesture.direction = .left
            view.addGestureRecognizer(swipeLeftGesture)
            self.view.addSubview(transparentView!)
            self.view.addSubview(sideMenuVC.view)
            self.view.bringSubviewToFront(sideMenuVC.view)
            sideMenuVC.view.frame = CGRect(x: -view.frame.width, y: 0, width: view.frame.width/1.5, height: UIScreen.main.bounds.height)
            
            UIView.animate(withDuration: 0.3) {
                sideMenuVC.view.frame.origin.x = 0
            }
            
            sideMenuVC.didMove(toParent: self)
        }
    }
    
    func removeSideMenu() {
        if let sideMenuVC = sideMenuVC {
            UIView.animate(withDuration: 0.3, animations: {
                sideMenuVC.view.frame.origin.x = -self.view.frame.width
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
    
    @objc func tapToCloseSideMenu(_ sender: UITapGestureRecognizer) {
        removeSideMenu()
    }
    
    func setupSwipeGesture() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeLeftGesture.direction = .left
        view.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeRightGesture.direction = .right
        view.addGestureRecognizer(swipeRightGesture)
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
