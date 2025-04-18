//
//  ViewController.swift
//  Assignment02
//
//  Created by Deepak Kaligotla on 10/03/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var history: UILabel!
    @IBOutlet weak var calc: UILabel!
    @IBOutlet weak var historyScrollView: UIScrollView!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    private var lastClearClickTime = 0
    private let buttonValues: [Int: String] = [
        100: "0", 101: "1", 102: "2", 103: "3", 104: "4",
        105: "5", 106: "6", 107: "7", 108: "8", 109: "9",
        200: "+", 201: "-", 202: "*", 203: "/"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if let value = buttonValues[sender.tag] {
            calc.text! += value
        } else if sender.tag == 300 {
            evaluateExpression()
        } else if sender.tag == 301 {
            handleClear()
        }
    }
    
    func evaluateExpression() {
        var expression = calc.text ?? ""
        if expression.isEmpty { return }
        expression = RegexHelper.cleanExpression(expression)
        guard RegexHelper.isValidMathExpression(expression) else {
            calc.text = "Invalid Input"
            return
        }
        let mathExpression = NSExpression(format: expression)
        if let result = mathExpression.expressionValue(with: nil, context: nil) as? NSNumber {
            let resultString = result.stringValue
            history.text = (history.text ?? "") + "\n\(expression) = \(resultString)"
            calc.text = resultString
            scrollToBottom()
        } else {
            calc.text = "Error"
        }
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let bottomOffset = CGPoint(x: 0, y: self.historyScrollView.contentSize.height - self.historyScrollView.bounds.height)
            if bottomOffset.y > 0 {
                self.historyScrollView.setContentOffset(bottomOffset, animated: true)
            }
        }
    }
    
    func handleClear() {
        lastClearClickTime += 1
        if lastClearClickTime > 1 {
            history.text = ""
            calc.text = ""
            lastClearClickTime = 0
            let alert = UIAlertController(title: "History Cleared", message: "Your history has been cleared.", preferredStyle: .alert)
            present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                alert.dismiss(animated: true)
            }
        } else {
            let alert = UIAlertController(title: nil, message: "Tap clear again to delete history", preferredStyle: .alert)
            present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alert.dismiss(animated: true)
            }
        }
    }
}
