//
//  PickersVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class PickersVC: UIViewController {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var secretMessage: UILabel!
    @IBOutlet weak var lockStatus: UILabel!
    var numbers: [Int] = []
    var letters: [String] = []
    let key: [String] = ["8", "S"]
    var combination: [String] = ["", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secretMessage.isHidden = true
        pickerView.dataSource = self
        pickerView.delegate = self
        for number in 0...9 {
            numbers.append(number)
        }
        for asciiValue in 65...90 {
            letters.append(String(UnicodeScalar(asciiValue)!))
        }
    }
    
    private func unlock() {
        if key[0] == combination[0] && key[1] == combination[1] {
            lockStatus.textColor = .green
            lockStatus.text = "Unlocked"
            secretMessage.isHidden = false
        } else {
            lockStatus.textColor = .red
            lockStatus.text = "Locked"
            secretMessage.isHidden = true
        }
    }
}

extension PickersVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return numbers.count
        } else {
            return letters.count
        }
    }
}

extension PickersVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(numbers[row])"
        } else {
            return letters[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            combination[component] = "\(numbers[row])"
        } else if component == 1 {
            combination[component] = letters[row]
        }
        self.unlock()
    }
    
    // Accessibility customization
    func pickerView(_ pickerView: UIPickerView, accessibilityLabelForComponent component: Int) -> String? {
        return "Component \(component + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, accessibilityHintForComponent component: Int) -> String? {
        return "Swipe up or down to select"
    }
    
    func pickerView(_ pickerView: UIPickerView, accessibilityValueForComponent component: Int) -> String? {
        let selectedRow = pickerView.selectedRow(inComponent: component)
        return "Row \(selectedRow + 1)"
    }
}
