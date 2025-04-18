//
//  ViewController.swift
//  NavigationDemo
//
//  Created by Deepak Kaligotla on 07/03/25.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1st VC - viewDidLoad")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("1st VC - viewWillAppear")
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("1st VC - viewDidAppear")
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("1st VC - viewWillDisappear")
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("1st VC - viewDidDisappear")
        super.viewDidDisappear(animated)
    }
    
    @IBAction func btnNextClicked(sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        secondViewController.backDataClosure = { name in
            print("Getting Data from closure")
            self.cityLabel.text = name
        }
        navigationController?.pushViewController(secondViewController, animated: true)
        
    }
}

//class FirstViewController: UIViewController, NavBackwardsProtocol {
//    @IBOutlet weak var cityLabel: UILabel!
//    @IBOutlet weak var nameTextField: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("1st VC - viewDidLoad")
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        print("1st VC - viewWillAppear")
//        super.viewWillAppear(animated)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        print("1st VC - viewDidAppear")
//        super.viewDidAppear(animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        print("1st VC - viewWillDisappear")
//        super.viewWillDisappear(animated)
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        print("1st VC - viewDidDisappear")
//        super.viewDidDisappear(animated)
//    }
//
//    @IBAction func btnNextClicked(sender: Any) {
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
//        as! SecondViewController
//        secondViewController.container = nameTextField.text
//        secondViewController.navBackwardProtocol = self
//        navigationController?.pushViewController(secondViewController, animated: true)
//    }
//
//    func passDataBack(data: String) {
//        print("Data from protocol")
//        self.cityLabel.text = data
//    }
//}

