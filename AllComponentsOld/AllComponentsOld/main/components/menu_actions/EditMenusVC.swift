//
//  EditMenusVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class EditMenusVC: UIViewController {
    @IBOutlet weak var textView: UITextView!
    var editMenuInteraction: UIEditMenuInteraction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editMenuInteraction = UIEditMenuInteraction(delegate: self)
        textView.addInteraction(editMenuInteraction!)
        textView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:))))
    }
    
    @objc
    func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        let configuration = UIEditMenuConfiguration(
            identifier: "textViewEdit",
            sourcePoint: gestureRecognizer.location(in: self.textView)
        )
        editMenuInteraction?.presentEditMenu(with: configuration)
    }
}

extension EditMenusVC: UIEditMenuInteractionDelegate {
    func editMenuInteraction(_ interaction: UIEditMenuInteraction,
                             menuFor configuration: UIEditMenuConfiguration,
                             suggestedActions: [UIMenuElement]) -> UIMenu? {
        
        var actions = suggestedActions
        let customMenu = UIMenu(title: "Edit Menu", options: .displayInline, children: [
            UIAction(title: "menuItem1") { _ in
                print("menuItem1")
            },
            UIAction(title: "menuItem2") { _ in
                print("menuItem2")
            },
            UIAction(title: "menuItem3") { _ in
                print("menuItem3")
            }
        ])
        actions.append(customMenu)
//        return UIMenu(children: actions)
        return UIMenu(children: customMenu.children)
    }
}
