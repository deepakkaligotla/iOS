//
//  CustomAlert.swift
//  AlertControllerDemo
//
//  Created by Deepak Kaligotla on 03/05/25.
//

import UIKit

class CustomAlertAction {
    let title: String
    let style: UIAlertAction.Style
    let completionHandler: ((CustomAlertAction) -> Void)?
    
    init(title: String, style: UIAlertAction.Style, completionHandler: ((CustomAlertAction) -> Void)? = nil) {
        self.title = title
        self.style = style
        self.completionHandler = completionHandler
    }
}

class CustomAlertView: UIViewController {
    private var alertTitle: String?
    private var alertMessage: String?
    private var actions: [CustomAlertAction] = []
    private let alertView = UIView()
    private let dimView = UIView()
    private var isAlertConfigured = false
    
    convenience init(title: String?, message: String?) {
        self.init()
        self.alertTitle = title
        self.alertMessage = message
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isAlertConfigured {
            setupAlertView()
            isAlertConfigured = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alertView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        alertView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.alertView.transform = .identity
            self.alertView.alpha = 1
        }
    }
    
    func addAction(_ action: CustomAlertAction) {
        actions.append(action)
    }
    
    private func setupBackground() {
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimView.frame = view.bounds
        dimView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(dimView)
    }
    
    private func setupAlertView() {
        alertView.backgroundColor = .systemBackground
        alertView.layer.cornerRadius = 16
        alertView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertView)
        
        let titleLabel = UILabel()
        titleLabel.text = alertTitle
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let messageLabel = UILabel()
        messageLabel.text = alertMessage
        messageLabel.font = .systemFont(ofSize: 16)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonStack = UIStackView()
        buttonStack.axis = .vertical
        buttonStack.spacing = 8
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, action) in actions.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(action.title, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
            button.tag = index
            button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
            
            switch action.style {
            case .default:
                button.setTitleColor(.systemBlue, for: .normal)
            case .cancel:
                button.setTitleColor(.darkGray, for: .normal)
            case .destructive:
                button.setTitleColor(.systemRed, for: .normal)
            @unknown default:
                break
            }
            
            buttonStack.addArrangedSubview(button)
        }
        
        alertView.addSubview(titleLabel)
        alertView.addSubview(messageLabel)
        alertView.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            
            buttonStack.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            buttonStack.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            buttonStack.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func handleButtonTap(_ sender: UIButton) {
        let action = actions[sender.tag]
        dismiss(animated: true) {
            action.completionHandler?(action)
        }
    }
}
