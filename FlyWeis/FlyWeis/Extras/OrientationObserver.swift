//
//  OrientationObserver.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 12/08/24.
//

import SwiftUI
import UIKit

class OrientationObserver: ObservableObject {
    @Published var orientation: UIDeviceOrientation = UIDevice.current.orientation

    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(orientationChanged),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    }

    @objc private func orientationChanged() {
        orientation = UIDevice.current.orientation
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
}
