//
//  WebViewsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit
import WebKit

class WebViewsVC: UIViewController {
    @IBOutlet weak var webViewScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWebViews()
    }
    
    func setupWebViews() {
        var offsetY: CGFloat = 20
        let webViews: [(WKWebView, String)] = [
            (self.simple(), "Simple"),
            (self.htmlLoadFromString(), "HTML from string"),
            (self.htmlLoadFromFile(), "HTML from file"),
            (self.evaluateJS(), "Evaluate JavaScript"),
            (self.injectUserScript(), "Inject UserScript"),
            (self.httpHeader(), "HTTP Header"),
        ]
        
        for (webView, detail) in webViews {
            webView.frame = CGRect(x: 0, y: 0, width: webViewScrollView.frame.width, height: 200)
            webView.layer.borderWidth = 1
            webView.layer.borderColor = UIColor.yellow.cgColor
            webView.frame.origin.y = offsetY
            webViewScrollView.addSubview(webView)
            
            let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.backgroundColor : UIColor.black,
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                NSAttributedString.Key.textEffect : NSAttributedString.TextEffectStyle.letterpressStyle
            ]
            let attributedString = NSAttributedString(string: detail, attributes: attributes)
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: webView.frame.width - 20, height: 20))
            label.attributedText = attributedString
            label.text = detail
            label.textColor = .white
            label.textAlignment = .right
            webView.addSubview(label)
            
            offsetY += webView.frame.size.height + 20
        }
        webViewScrollView.contentSize = CGSize(width: webViewScrollView.frame.width, height: offsetY)
    }
    
    private func simple() -> WKWebView {
        let simpleWebView = WKWebView(frame: .zero)
        let url = URL(string: "https://www.kaligotla.in")
        let request = URLRequest(url: url!)
        simpleWebView.load(request)
        return simpleWebView
    }
    
    private func htmlLoadFromString() -> WKWebView {
        let htmlWebView = WKWebView(frame: .zero)
        let htmlString = "<html><body><h1>Hello, World!</h1></body></html>"
        htmlWebView.loadHTMLString(htmlString, baseURL: nil)
        return htmlWebView
    }
    
    private func htmlLoadFromFile() -> WKWebView {
        let htmlWebView = WKWebView(frame: .zero)
        if let htmlFileURL = Bundle.main.url(forResource: "test", withExtension: "html") {
            htmlWebView.loadFileURL(htmlFileURL, allowingReadAccessTo: htmlFileURL)
            let request = URLRequest(url: htmlFileURL)
            htmlWebView.load(request)
        }
        return htmlWebView
    }
    
    private func evaluateJS() -> WKWebView {
        let javaScriptWebView = WKWebView(frame: .zero)
        let script = "document.body.style.backgroundColor = 'lightblue';"
        javaScriptWebView.evaluateJavaScript(script, completionHandler: nil)
        return javaScriptWebView
    }
    
    private func injectUserScript() -> WKWebView {
        let webView = WKWebView(frame: .zero)
        let script = WKUserScript(source: "document.body.style.backgroundColor = 'lightyellow';", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        webView.configuration.userContentController.addUserScript(script)
        if let url = URL(string: "https://developer.apple.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    private func httpHeader() -> WKWebView {
        let httpHeader = WKWebView(frame: .zero)
        let url = URL(string: "https://www.apple.com")
        var request = URLRequest(url: url!)
        request.setValue("Bearer YOUR_ACCESS_TOKEN", forHTTPHeaderField: "Authorization")
        httpHeader.load(request)
        return httpHeader
    }
}
