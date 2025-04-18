//
//  LabelsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class LabelsVC: UIViewController {
    @IBOutlet weak var labelsScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabels()
    }
    
    private func setupLabels() {
        var offsetY: CGFloat = 20
        let labels: [(UILabel, String)] = [
            (standardLabel(), "Standard"),
            (attributedLabel(), "Attributed"),
            (multilineLabel(), "Multiline"),
            (dynamicFontLabel(), "Dynamic Font"),
            (customFontLabel(), "Custom Font")
        ]
        
        for (label, detail) in labels {
            label.frame = CGRect(x: 0, y: 0, width: labelsScrollView.frame.width, height: 100)
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.yellow.cgColor
            label.frame.origin.y = offsetY
            labelsScrollView.addSubview(label)
            
            let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.backgroundColor : UIColor.black,
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                NSAttributedString.Key.textEffect : NSAttributedString.TextEffectStyle.letterpressStyle
            ]
            let attributedString = NSAttributedString(string: detail, attributes: attributes)
            let title = UILabel(frame: CGRect(x: 10, y: 10, width: label.frame.width - 20, height: 20))
            title.attributedText = attributedString
            title.text = detail
            title.textColor = .white
            title.textAlignment = .right
            label.addSubview(title)
            
            offsetY += label.frame.size.height + 20
        }
        labelsScrollView.contentSize = CGSize(width: labelsScrollView.frame.width, height: offsetY)
    }
    
    private func standardLabel() -> UILabel {
        let standard = UILabel()
        standard.text = "STANDARD TEXT"
        standard.font = UIFont.systemFont(ofSize: 30)
        standard.textAlignment = .center
        return standard
    }
    
    private func attributedLabel() -> UILabel {
        let attributed = UILabel()
        attributed.text = "Attributed Text"
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.random,
            NSAttributedString.Key.backgroundColor : UIColor.random,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30),
            NSAttributedString.Key.textEffect : NSAttributedString.TextEffectStyle.letterpressStyle
        ]
        attributed.attributedText = NSAttributedString(string: attributed.text!, attributes: attributes)
        attributed.textAlignment = .center
        return attributed
    }
    
    private func multilineLabel() -> UILabel {
        let multiline = UILabel()
        multiline.text = String(repeating: "Multilined Text...", count: 10)
        multiline.numberOfLines = 5
        return multiline
    }
    
    private func dynamicFontLabel() -> UILabel {
        let dynamicFont = UILabel()
        dynamicFont.text = "Dynamic Font"
        dynamicFont.font = UIFont.preferredFont(forTextStyle: .body)
        dynamicFont.font = UIFont.systemFont(ofSize: 30)
        dynamicFont.adjustsFontForContentSizeCategory = true
        dynamicFont.textAlignment = .center
        return dynamicFont
    }
    
    private func customFontLabel() -> UILabel {
        let customFont = UILabel()
        customFont.text = "\u{e049} \u{e052} \u{e16d} \u{e07B} \u{e340} \u{e40f} \u{e49b} \u{e5ae} \u{e61b} \u{f099} \u{f082} \u{f08c} \u{f09b} \u{f0d2} \u{f0d5} \u{f0e1} \u{f13b} \u{f167} \u{f16c} \u{f171} \u{f179} \u{f17a} \u{f17b} \u{f17c} \u{f1a0} \u{f1d3} \u{f1ed} \u{f1ee} \u{f1f0} \u{f1f1} \u{f1f2} \u{f1f3} \u{f1f4} \u{f1f5} \u{f232} \u{f23a} \u{f268} \u{f270} \u{f287} \u{f294} \u{f2ab} \u{f2c5} \u{f36f} \u{f375} \u{f38b} \u{f395} \u{f3ab} \u{f3b4} \u{f3b6} \u{f3b9} \u{f3d3} \u{f3d4} \u{f3e2} \u{f415} \u{f419} \u{f41b} \u{f41e} \u{f41f} \u{f420} \u{f42c} \u{f4e4} \u{f59e} \u{f6cc} \u{f799} \u{f838} \u{f83b} \u{f8e1}"
        if let customFontName = UIFont(name: "Font Awesome 6 Brands", size: 12) {
            customFont.font = customFontName
        } else {
            customFont.font = UIFont.systemFont(ofSize: 30)
        }
        customFont.numberOfLines = 5
        customFont.textAlignment = .center
        return customFont
    }
}
