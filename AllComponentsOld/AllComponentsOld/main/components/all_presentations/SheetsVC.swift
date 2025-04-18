//
//  SheetsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class SheetsVC: UIViewController {
    @IBAction func showSheetBtn(_ sender: UIBarButtonItem) {
        guard presentedViewController == nil else {
            dismiss(animated: true, completion: {
                self.showSheetBtn(sender)
            })
            return
        }
        let sheetVC = SheetVC()
        sheetVC.modalPresentationStyle = .popover
        if let popover = sheetVC.popoverPresentationController {
            popover.barButtonItem = sender
            let sheet = popover.adaptiveSheetPresentationController
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        self.present(sheetVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
    }
}

class SheetVC: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 229/255, green: 184/255, blue: 11/255, alpha: 0.75)
    }
}
