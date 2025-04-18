//
//  LockScreenWidgetBundle.swift
//  LockScreenWidget
//
//  Created by Deepak Kaligotla on 15/06/24.
//

import WidgetKit
import SwiftUI

@main
struct LockScreenWidgetBundle: WidgetBundle {
    var body: some Widget {
        LockScreenWidget()
        LockScreenWidgetLiveActivity()
    }
}
