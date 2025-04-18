//
//  VirtualKeyboardsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class CustomKeyboardView: UIView {
    var textField: UITextField?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupKeyboard()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupKeyboard()
    }
    
    private func setupKeyboard() {
        self.backgroundColor = .random
        
        let buttonTitles = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "Done"]
        let buttons: [UIButton] = buttonTitles.map { title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
            return button
        }
        
        let gridLayout = UIStackView(arrangedSubviews: buttons.chunked(into: 3).map { row in
            let rowStackView = UIStackView(arrangedSubviews: row)
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 5
            return rowStackView
        })
        
        gridLayout.axis = .vertical
        gridLayout.distribution = .fillEqually
        gridLayout.spacing = 5
        gridLayout.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(gridLayout)
        
        NSLayoutConstraint.activate([
            gridLayout.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            gridLayout.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            gridLayout.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            gridLayout.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    @objc private func keyPressed(_ sender: UIButton) {
        guard let text = sender.title(for: .normal), let textField = textField else { return }
        
        if text == "Done" {
            textField.resignFirstResponder()
        } else {
            textField.insertText(text)
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        var chunks: [[Element]] = []
        for i in stride(from: 0, to: count, by: size) {
            chunks.append(Array(self[i..<Swift.min(i + size, count)]))
        }
        return chunks
    }
}

class VirtualKeyboardsVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customKeyboard = CustomKeyboardView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250))
        customKeyboard.textField = textField
        textField.inputView = customKeyboard
    }
}
