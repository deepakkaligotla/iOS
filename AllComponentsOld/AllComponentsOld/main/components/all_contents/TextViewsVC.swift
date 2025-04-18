//
//  TextViewsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class TextViewsVC: UIViewController {
    @IBOutlet weak var textViewScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextViews()
    }
    
    func setupTextViews() {
        var offsetY: CGFloat = 20
        let textViews: [(UITextView, String)] = [
            (self.placeholder(), "Placeholder"),
            (self.limitedCharCount(), "Limited Char Count"),
            (self.customStyling(), "Custom Styling")
        ]
        
        for (textView, detail) in textViews {
            textView.frame = CGRect(x: 0, y: 0, width: textViewScrollView.frame.width, height: 200)
            textView.layer.borderWidth = 1
            textView.layer.borderColor = UIColor.yellow.cgColor
            textView.frame.origin.y = offsetY
            textViewScrollView.addSubview(textView)
            
            let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.backgroundColor : UIColor.black,
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                NSAttributedString.Key.textEffect : NSAttributedString.TextEffectStyle.letterpressStyle
            ]
            let attributedString = NSAttributedString(string: detail, attributes: attributes)
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: textView.frame.width - 20, height: 20))
            label.attributedText = attributedString
            label.text = detail
            label.textColor = .white
            label.textAlignment = .right
            textView.addSubview(label)
            
            offsetY += textView.frame.size.height + 20
        }
        textViewScrollView.contentSize = CGSize(width: textViewScrollView.frame.width, height: offsetY)
    }
    
    private func placeholder() -> UITextView {
        let placeholderTextView = UITextView()
        placeholderTextView.text = "Enter your text here..."
        placeholderTextView.textColor = UIColor.lightGray

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "Enter your text here..."
                textView.textColor = UIColor.lightGray
            }
        }
        return placeholderTextView
    }
    
    private func limitedCharCount() -> UITextView {
        let limitedTextView = UITextView()
        let maxLength = 100

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            return newText.count <= maxLength
        }
        return limitedTextView
    }
    
    private func customStyling() -> UITextView {
        let styledTextView = UITextView()
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.backgroundColor: UIColor.yellow
        ]
        styledTextView.attributedText = NSAttributedString(string: "Custom Styled Text", attributes: attributes)
        return styledTextView
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
