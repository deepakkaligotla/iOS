//
//  SlidersVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class SlidersVC: UIViewController {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var valueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSlider()
        updateValueLabel(slider.value)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        updateValueLabel(sender.value)
    }
    
    private func configureSlider() {
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        slider.minimumTrackTintColor = .blue
        slider.maximumTrackTintColor = .gray
        slider.thumbTintColor = .red
        
        slider.minimumValueImage = UIImage(systemName: "tortoise.fill")
        slider.maximumValueImage = UIImage(systemName: "hare.fill")
    }
    
    private func updateValueLabel(_ value: Float) {
        valueLabel.text = String(format: "%.2f", value)
    }
}
