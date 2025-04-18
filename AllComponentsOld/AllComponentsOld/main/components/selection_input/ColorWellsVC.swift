//
//  ColorWellsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class ColorWellsVC: UIViewController {
    var colorPickerVC: ColorPickerVC?

    @IBAction func showColorWell(_ sender: Any) {
        if colorPickerVC == nil {
            colorPickerVC = ColorPickerVC()
        }
        guard let colorPickerVC = colorPickerVC else { return }
        presentColorPicker(parentViewController: self, viewController: colorPickerVC, sender: sender as! UIView, size: CGSize(width: 350, height: 400), arrowDirection: .any)
        colorPickerVC.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func presentColorPicker(parentViewController: UIViewController, viewController: UIViewController, sender: UIView, size: CGSize, arrowDirection: UIPopoverArrowDirection = .any) {
        viewController.preferredContentSize = size
        viewController.modalPresentationStyle = .popover
        if let pres = viewController.presentationController {
            pres.delegate = self
        }
        parentViewController.present(viewController, animated: true)
        if let pop = viewController.popoverPresentationController {
            pop.sourceView = sender
            pop.sourceRect = sender.bounds
            pop.permittedArrowDirections = arrowDirection
        }
    }
}

extension ColorWellsVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

extension ColorWellsVC: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        dismiss(animated: true, completion: nil)
    }

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        view.backgroundColor = color
    }
}

class ColorPickerVC: UIColorPickerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
