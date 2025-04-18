//
//  SegmentedControlsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class SegmentedControlsVC: UIViewController {
    @IBOutlet weak var selectedSegment: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateSelectedSegmentLabel()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateSelectedSegmentLabel()
    }

    private func updateSelectedSegmentLabel() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.selectedSegment.text = "First"
        case 1:
            self.selectedSegment.text = "Second"
        case 2:
            self.selectedSegment.text = "Third"
        case 3:
            self.selectedSegment.text = "Fourth"
        default:
            self.selectedSegment.text = ""
        }
    }
}

