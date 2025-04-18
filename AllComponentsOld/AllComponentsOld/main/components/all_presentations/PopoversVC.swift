//
//  PopoversVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class PopoversVC: UIViewController {
    @IBOutlet weak var popoverBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popoverBtn?.addTarget(self, action: #selector(showPopover), for: .touchUpInside)
    }
    
    @objc private func showPopover() {
        presentPopover(self, PopoverVC(), sender: popoverBtn, size: CGSize(width: 300, height: 200), arrowDirection: .any)
    }
    
    func presentPopover(_ parentViewController: UIViewController, _ viewController: UIViewController, sender: UIView, size: CGSize, arrowDirection: UIPopoverArrowDirection = .any) {
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

extension PopoversVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

class PopoverVC: UIViewController {
    @IBOutlet weak var popoverBtn: UIButton!
    
    init() {
        super.init(nibName: "PopoverVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        self.popoverBtn?.addTarget(self, action: #selector(popoverActionBtn), for: .touchUpInside)
    }
    
    @objc private func popoverActionBtn() {
        print("Popover Action Button Clicked")
    }
}
