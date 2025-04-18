//
//  ContextMenusVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class ContextMenusVC: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.addInteraction(UIContextMenuInteraction(delegate: self))
    }
}

extension ContextMenusVC: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            let item1 = UIAction(title: "Action 1", image: UIImage(systemName: "star")) { _ in
                // Handle action 1
            }

            let item2 = UIAction(title: "Action 2", image: UIImage(systemName: "heart")) { _ in
                // Handle action 2
            }
            return UIMenu(title: "Context Menus", children: [item1, item2])
        })
    }
}
