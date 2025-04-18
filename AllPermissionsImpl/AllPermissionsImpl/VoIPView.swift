//
//  VoIPView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 06/04/24.
//

import SwiftUI
import PushKit
import CallKit
import AVFoundation

class CallManager {
    var calls: [VoipCall] = []

    func addCall(_ call: VoipCall) {
        calls.append(call)
    }
}

struct VoipCall {
    let uuid: UUID
    let phoneNumber: CXHandle
}

class VoIPDelegate: NSObject, PKPushRegistryDelegate, ObservableObject, CXProviderDelegate {
    var callProvider: CXProvider?
    var callManager: CallManager?
    
    override init() {
        super.init()
        callProvider = CXProvider(configuration: CXProviderConfiguration(localizedName: "Your App Name"))
        callManager = CallManager()
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        // Register VoIP push token (a property of PKPushCredentials) with server
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        if type == .voIP {
            if let handle = payload.dictionaryPayload["handle"] as? String,
               let uuidString = payload.dictionaryPayload["callUUID"] as? String,
               let callUUID = UUID(uuidString: uuidString) {
                let callUpdate = CXCallUpdate()
                let phoneNumber = CXHandle(type: .phoneNumber, value: handle)
                
                callUpdate.remoteHandle = phoneNumber
                callProvider?.reportNewIncomingCall(with: callUUID, update: callUpdate, completion: { (error) in
                    if error == nil {
                        let newCall = VoipCall(uuid: callUUID, phoneNumber: phoneNumber)
                        self.callManager?.addCall(newCall)
                    }
                    completion()
                })
                establishConnection(for: callUUID)
            }
        }
    }
    
    func establishConnection(for callUUID: UUID) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .voiceChat, options: [.allowBluetooth, .allowBluetoothA2DP])
            try audioSession.setActive(true)
            
            switch audioSession.recordPermission {
            case .granted:
                print("VoIP permission granted")
                establishConnectionLogic()
            case .denied:
                print("VoIP permission denied")
            case .undetermined:
                print("VoIP permission undetermined")
                audioSession.requestRecordPermission { granted in
                    if granted {
                        self.establishConnectionLogic()
                    } else {
                        
                    }
                }
            @unknown default:
                fatalError()
            }
        } catch {
            print("Error configuring audio session: \(error.localizedDescription)")
            return
        }
    }
    
    func establishConnectionLogic() {
        let voipServerAddress = "your_voip_server_address"
        let voipServerPort = 1234
        let url = URL(string: "http://\(voipServerAddress):\(voipServerPort)/connect")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error connecting to VoIP server: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            print("Connected to VoIP server. Server response: \(String(data: data, encoding: .utf8) ?? "")")
        }.resume()
    }
    
    func providerDidReset(_ provider: CXProvider) {
        
    }
}

struct VoIPView: View {
    @StateObject var voipDelegate = VoIPDelegate()
    
    var body: some View {
        VStack {
            Text("VoIP Calls")
                .font(.title)
                .padding()
            
            Text("Your app is now ready to receive VoIP calls.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
        }
        .onAppear {
            self.voipRegistration()
        }
    }
    
    func voipRegistration() {
        let mainQueue = DispatchQueue.main
        let voipRegistry = PKPushRegistry(queue: mainQueue)
        voipRegistry.delegate = voipDelegate
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
    }
}


struct VoIPView_Previews: PreviewProvider {
    static var previews: some View {
        VoIPView()
    }
}
