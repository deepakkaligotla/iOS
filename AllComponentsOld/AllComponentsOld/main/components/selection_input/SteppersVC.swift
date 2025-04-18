//
//  SteppersVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class SteppersVC: UIViewController {
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var valueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStepper()
        updateValueLabel(stepper.value)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateValueLabel(sender.value)
    }
    
    private func configureStepper() {
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.stepValue = 1
        stepper.value = 5
        stepper.autorepeat = true
        stepper.wraps = false
        stepper.tintColor = .blue
    }
    
    private func updateValueLabel(_ value: Double) {
        valueLabel.text = String(format: "%.0f", value)
    }
}

