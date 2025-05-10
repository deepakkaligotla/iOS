//
//  ViewController.swift
//  SegmentedControlDemo
//
//  Created by Deepak Kaligotla on 07/05/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstSegmentContainerView: UIView!
    @IBOutlet weak var secondSegmentContainerView: UIView!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstSegmentContainerView.isHidden = false
        secondSegmentContainerView.isHidden = true
    }
    
    @IBAction func segementChange(_ sender: Any) {
        switch (mySegmentedControl.selectedSegmentIndex) {
            case 0:
            firstSegmentContainerView.isHidden = false
            secondSegmentContainerView.isHidden = true
            case 1:
            firstSegmentContainerView.isHidden = true
            secondSegmentContainerView.isHidden = false
        default:
            firstSegmentContainerView.isHidden = true
            secondSegmentContainerView.isHidden = true
        }
    }
}
