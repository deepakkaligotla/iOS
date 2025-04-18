//
//  MenusVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class MenusVC: UIViewController {
    @IBOutlet weak var fileBtn: UIButton!
    @IBOutlet weak var infoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFileButton()
        self.setupAboutButton()
    }
    
    private func setupAboutButton() {
        let team = UIAction(title: "Team", image: UIImage(systemName: "person.3.sequence")) { action in }
        let mission_values = UIAction(title: "Mission and Values", image: UIImage(systemName: "hands.and.sparkles")) { action in }
        let contact = UIAction(title: "Contact me", image: UIImage(systemName: "person.crop.circle.fill")) { action in }
        let mediaKit = UIAction(title: "Media Kit", image: UIImage(systemName: "tv.and.mediabox")) { action in }
        let faq = UIAction(title: "FAQ's", image: UIImage(systemName: "questionmark.bubble")) { action in }
        self.infoBtn.menu = UIMenu(title: "About", subtitle: nil, image: UIImage(systemName: "info.circle"), identifier: .about, options: .singleSelection, children: [team, mission_values, contact, mediaKit, faq])
        self.fileBtn.showsMenuAsPrimaryAction = true
    }
    
    private func setupFileButton() {
        self.fileBtn.menu = UIMenu(title: "Add", subtitle: nil, image: UIImage(systemName: "doc"), children: [
            UIAction(title: "Create a file", image: UIImage(systemName: "doc")) { action in },
            UIAction(title: "Create a folder", image: UIImage(systemName: "folder")) { action in },
            UIMenu(title: "Secondary actions", children: [
                UIAction(title: "Remove old files", image: UIImage(systemName: "trash"), attributes: .destructive) { action in }
            ])
        ])
        self.infoBtn.showsMenuAsPrimaryAction = true
    }
}
