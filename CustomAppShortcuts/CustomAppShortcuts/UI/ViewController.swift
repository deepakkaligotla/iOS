//
//  ViewController.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 15/06/24.
//

import ActivityKit
import UIKit

class ViewController: UIViewController {
    var deliveryActivity: Activity<LockScreenWidgetAttributes>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startActivity(_ sender: UIButton) {
        startDeliveryActivity()
    }
    
    @IBAction func updateActivity(_ sender: UIButton) {
        updateDeliveryActivity(status: "Arriving soon", emoji: "🚗")
    }
    
    @IBAction func endActivity(_ sender: UIButton) {
        endDeliveryActivity()
    }
}

extension ViewController {
    func startDeliveryActivity() {
        do {
            deliveryActivity = try Activity<LockScreenWidgetAttributes>.request(
                attributes: LockScreenWidgetAttributes(name: "Delivery"),
                contentState: LockScreenWidgetAttributes.ContentState(emoji: "🍔", endTime: Date()),
                pushType: nil
            )
            print("Requested a Live Activity: \(String(describing: deliveryActivity?.id))")
        } catch (let error) {
            print("Error requesting Live Activity: \(error.localizedDescription)")
        }
    }
}

extension ViewController {
    func updateDeliveryActivity(status: String, emoji: String) {
        Task {
            await deliveryActivity?.update(using: LockScreenWidgetAttributes.ContentState(emoji: emoji, endTime: Date()))
        }
    }
}

extension ViewController {
    func endDeliveryActivity() {
        Task {
            await deliveryActivity?.end(dismissalPolicy: .immediate)
        }
    }
}

