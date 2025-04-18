//
//  FaceIDView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import LocalAuthentication

struct FaceIDView: View {
    @State private var biometricType: LABiometryType = .none
    @State private var isBiometricEnrolled = false
    @State private var isPasscodeSet = false
    @State private var isUserAuthorized = false

    var body: some View {
        Group {
            if biometricType == .faceID || biometricType == .touchID || biometricType == .opticID {
                if isBiometricEnrolled {
                    if isUserAuthorized {
                        VStack {
                            Text("Successfully authenticated with \(biometricType.description)")
                            Text("Showing secure sensitive information")
                        }
                    } else {
                        Text("Require biometrics to see the secure information")
                        Button {
                            checkBiometricRegistration()
                        } label: {
                            switch biometricType.description {
                            case "Touch ID":
                                Image(systemName: "touchid").foregroundColor(.red).font(.largeTitle)
                            case "Face ID":
                                Image(systemName: "faceid").foregroundColor(.red).font(.largeTitle)
                            case "Optic ID":
                                Image(systemName: "opticid").foregroundColor(.red).font(.largeTitle)
                            default:
                                Image(systemName: "lock.circle.dotted").foregroundColor(.red).font(.largeTitle)
                            }
                        }
                    }
                } else {
                    VStack {
                        Text("\(biometricType.description) is available but not registered on this device")
                    }
                }
            } else {
                if isPasscodeSet {
                    if isUserAuthorized {
                        VStack {
                            Text("Successfully authenticated with device passcode")
                            Text("Showing secure sensitive information")
                        }
                    } else {
                        Text("Require biometrics to see the secure information")
                        Button {
                            checkPasscode()
                        } label: {
                            Image(systemName: "lock.circle.dotted").foregroundColor(.red).font(.largeTitle)
                        }
                    }
                } else {
                    Text("No biometric authentication or passcode set on this device")
                }
            }
        }
        .onAppear {
            checkBiometricType()
            checkBiometricRegistration()
            checkPasscode()
        }
    }

    private func checkBiometricType() {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            biometricType = context.biometryType
        }
    }

    private func checkBiometricRegistration() {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate with Biometrics") { success, error in
                DispatchQueue.main.async {
                    if let error = error as? LAError {
                        switch error.code {
                        case .userCancel, .appCancel, .systemCancel, .userFallback, .authenticationFailed:
                            isUserAuthorized = false
                            isBiometricEnrolled = true
                        case .touchIDNotEnrolled, .biometryNotEnrolled:
                            isUserAuthorized = false
                            isBiometricEnrolled = false
                        default:
                            isUserAuthorized = false
                        }
                    } else {
                        isBiometricEnrolled = success
                        isUserAuthorized = true
                    }
                }
            }
        }
    }

    private func checkPasscode() {
        let context = LAContext()
        if LAContext().canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Authenticate with Biometrics") { success, error in
                DispatchQueue.main.async {
                    if let error = error as? LAError {
                        switch error.code {
                        case .userCancel, .appCancel, .systemCancel, .userFallback, .authenticationFailed:
                            isUserAuthorized = false
                            isPasscodeSet = true
                        case .passcodeNotSet:
                            isUserAuthorized = false
                            isPasscodeSet = false
                        default:
                            isUserAuthorized = false
                        }
                    } else {
                        isPasscodeSet = true
                        isUserAuthorized = true
                    }
                }
            }
        }
    }
}

extension LABiometryType {
    var description: String {
        switch self {
        case .faceID: return "Face ID"
        case .touchID: return "Touch ID"
        case .opticID: return "Optic ID"
        default: return "Biometric"
        }
    }
}

struct FaceIDView_Previews: PreviewProvider {
    static var previews: some View {
        FaceIDView()
    }
}
