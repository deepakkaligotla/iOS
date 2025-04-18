//
//  FocusView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import Intents
import UserNotifications

class FocusViewModel: ObservableObject {
    @Published var liveFocusState: Bool = false
    @Published var isNotificationAuthorized: Bool = false
    @Published var isFocusAuthorized: Bool = false
    let authorizationOptions: UNAuthorizationOptions
    private var timer: Timer?
    
    init() {
        if #available(iOS 15, watchOS 8.0, macOS 12, *) {
            authorizationOptions = [.badge, .sound, .alert, .timeSensitive]
        } else {
            authorizationOptions = [.badge, .sound, .alert]
        }
        self.isNotificationAuthorized = INFocusStatusCenter.default.authorizationStatus == .authorized
        self.isFocusAuthorized = INFocusStatusCenter.default.authorizationStatus == .authorized
    }
    
    func requestUserNotificationsAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: authorizationOptions) { isGranted, error in
            if let error = error {
                self.isNotificationAuthorized = false
            } else if !isGranted {
                self.isNotificationAuthorized = false
            } else {
                UNUserNotificationCenter.current().getNotificationSettings { notificationSettings in
                    switch notificationSettings.authorizationStatus {
                    case .notDetermined:
                        self.isNotificationAuthorized = false
                    case .denied:
                        self.isNotificationAuthorized = false
                    case .authorized:
                        self.isNotificationAuthorized = true
                    default:
                        self.isNotificationAuthorized = false
                    }
                }
            }
        }
    }
    
    func requestFocusStatusAuthorization() {
        INFocusStatusCenter.default.requestAuthorization { status in
            switch status {
            case .denied:
                self.isFocusAuthorized = false
            case .authorized:
                self.isFocusAuthorized = true
            case .notDetermined:
                self.isFocusAuthorized = false
            case .restricted:
                self.isFocusAuthorized = false
            @unknown default:
                self.isFocusAuthorized = false
            }
        }
    }
    
    func startObservingFocus() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            DispatchQueue.main.async {
                self.getLiveFocusState()
            }
        }
    }
    
    private func getLiveFocusState() {
        if #available(iOS 15.0, watchOS 8.0, macOS 12.0, *) {
            guard let isFocused = INFocusStatusCenter.default.focusStatus.isFocused else {
                self.liveFocusState = false
                return
            }
            self.liveFocusState = isFocused
        } else {
            print("Focus Status Unavailable")
        }
    }
}

struct FocusView: View {
    @ObservedObject private var viewModel = FocusViewModel()
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Focus Permissions").font(.headline)) {
                    if self.viewModel.isNotificationAuthorized {
                        Text("Notifications Permission Granted")
                    } else {
                        Button {
                            self.viewModel.requestUserNotificationsAuthorization()
                        } label: {
                            Text("Grant Notifications Permission")
                        }
                    }
                    
                    if self.viewModel.isFocusAuthorized {
                        Text("Focus status Permission Granted")
                    } else {
                        Button {
                            self.viewModel.requestFocusStatusAuthorization()
                        } label: {
                            Text("Grant Focus Permission")
                        }
                    }
                }
                
                Section(header: Text("Focus Status").font(.headline)) {
                    Text(self.viewModel.liveFocusState ? "Focus is ON" : "Focus is OFF")
                        .onAppear {
                            if self.viewModel.isFocusAuthorized {
                                self.viewModel.startObservingFocus()
                            }
                        }
                }
            }
        }
    }
}

struct FocusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusView()
    }
}
