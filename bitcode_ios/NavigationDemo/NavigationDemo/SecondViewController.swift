//
//  SecondViewController.swift
//  NavigationDemo
//
//  Created by Deepak Kaligotla on 07/03/25.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityTextFiel: UITextField!
    var container: String?
    var navBackwardProtocol: NavBackwardsProtocol?
    var backDataClosure: ((String)->Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("2nd VC - viewDidLoad")
//        navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        extractDataAndBind()
    }
    
    func extractDataAndBind() {
        nameLabel.text = container
    }
    
    @IBAction func btnPrevious(sender: Any) {
        guard let dataProtocol = navBackwardProtocol else { return }
        dataProtocol.passDataBack(data: cityTextFiel.text == "" ? "Hyderabad" : cityTextFiel.text!)
        guard let backDataClosure = backDataClosure else { return }
        backDataClosure(cityTextFiel.text == "" ? "Hyderabad" : cityTextFiel.text!)
        navigationController?.popViewController(animated: true)
    }
}
