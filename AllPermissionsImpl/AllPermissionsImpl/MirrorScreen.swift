//
//  MirrorScreen.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 07/04/24.
//

import SwiftUI
import GoogleCast

class GoogleCastViewModel: NSObject, ObservableObject {
    let kReceiverAppID = kGCKDefaultMediaReceiverApplicationID
    
    override init() {
        super.init()
        let options = GCKCastOptions(discoveryCriteria: GCKDiscoveryCriteria(applicationID: kReceiverAppID))
        options.physicalVolumeButtonsWillControlDeviceVolume = true
        let launchOptions = GCKLaunchOptions()
        launchOptions.androidReceiverCompatible = true
        options.launchOptions = launchOptions
        GCKCastContext.setSharedInstanceWith(options)
        GCKCastContext.sharedInstance().useDefaultExpandedMediaControls = true
        GCKUICastButton.appearance().tintColor = UIColor.gray
    }
}

extension GoogleCastViewModel: GCKSessionManagerListener {
    func sessionManager(_: GCKSessionManager, didEnd _: GCKSession, withError error: Error?) {
        if error == nil {
            print("Session ended")
        } else {
            let message = "Session ended unexpectedly:\n\(error?.localizedDescription ?? "")"
            showAlert(withTitle: "Session error", message: message)
        }
    }
    
    func sessionManager(_: GCKSessionManager, didFailToStart _: GCKSession, withError error: Error) {
        let message = "Failed to start session:\n\(error.localizedDescription)"
        showAlert(withTitle: "Session error", message: message)
    }
    
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
    }
}

struct CastButton: UIViewRepresentable {
    func makeUIView(context: Context) -> GCKUICastButton {
        return GCKUICastButton(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
    }
    
    func updateUIView(_ uiView: GCKUICastButton, context: Context) { }
}

struct MirrorScreen: View {
    @StateObject private var castVM = GoogleCastViewModel()
    
    var body: some View {
        VStack {
            CastButton()
        }
        .onAppear {
            GCKCastContext.sharedInstance().sessionManager.add(castVM)
        }
    }
}

struct MirrorScreen_Previews: PreviewProvider {
    static var previews: some View {
        MirrorScreen()
    }
}
