//
//  TogglesVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class TogglesVC: UIViewController {
    @IBOutlet weak var switchUI: UISwitch!
    @IBOutlet weak var stateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSwitch()
        updateStateLabel(isOn: switchUI.isOn)
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        updateStateLabel(isOn: sender.isOn)
    }
    
    private func configureSwitch() {
        switchUI.isOn = false
        switchUI.onTintColor = .green
        switchUI.thumbTintColor = .white
        switchUI.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    private func updateStateLabel(isOn: Bool) {
        stateLabel.text = isOn ? "Switch is ON" : "Switch is OFF"
    }
}

