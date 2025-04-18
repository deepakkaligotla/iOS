//
//  SplashViewController.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 02/05/24.
//

import UIKit
import SwiftyGif

class SplashViewController: UIViewController {
    @IBOutlet weak var gifImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let gif = try? UIImage(gifName: "Logo.gif") {
            gifImageView.setGifImage(gif, loopCount: 1)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gifImageView.startAnimatingGif()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.transitionToMainInterface()
        }
    }
    
    func transitionToMainInterface() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainVC {
                    window.rootViewController = mainViewController
                    window.makeKeyAndVisible()
                }
            }
        }
    }
}

#Preview {
    SplashViewController()
}
