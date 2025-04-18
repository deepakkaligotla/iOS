//
//  ScrollViewsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class ScrollViewsVC: UIViewController {
    @IBOutlet weak var verticalSV: UIScrollView!
    let sections: [String] = ["Home", "Movies", "Series", "My List", "Popular"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNestedScrollView()
    }
    
    private func setupNestedScrollView() {
        var offsetY: CGFloat = 1
        
        for sectionIndex in 0..<sections.count {
            let section = sections[sectionIndex]
            
            let sectionView = UIView()
            sectionView.frame = CGRect(x: 0, y: offsetY, width: verticalSV.frame.width, height: 150)
            
            let sectionLabel = UILabel(frame: CGRect(x: 10, y: 10, width: sectionView.frame.width - 20, height: 30))
            sectionLabel.text = section
            sectionView.addSubview(sectionLabel)
            
            let horizontalSV = UIScrollView(frame: CGRect(x: 0, y: 50, width: verticalSV.frame.width, height: 100))
            horizontalSV.showsHorizontalScrollIndicator = true
            horizontalSV.layer.borderWidth = 1
            horizontalSV.layer.borderColor = UIColor.blue.cgColor
            
            var xOffset: CGFloat = 10
            for _ in 0..<10 {
                let imageView = UIImageView(image: UIImage(systemName: "video", withConfiguration: UIImage.SymbolConfiguration(scale: .large)))
                imageView.contentMode = .scaleAspectFit
                imageView.frame = CGRect(x: xOffset, y: 0, width: 70, height: 100)
                imageView.layer.borderWidth = 1
                imageView.layer.borderColor = UIColor.yellow.cgColor
                horizontalSV.addSubview(imageView)
                xOffset += imageView.frame.width + 10
            }
            
            horizontalSV.contentSize = CGSize(width: xOffset, height: 100)
            sectionView.addSubview(horizontalSV)
            verticalSV.addSubview(sectionView)
            offsetY += sectionView.frame.size.height + 20
        }
        verticalSV.contentSize = CGSize(width: verticalSV.frame.width, height: offsetY)
    }
}
