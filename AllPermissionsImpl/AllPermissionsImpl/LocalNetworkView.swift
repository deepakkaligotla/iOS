//
//  NetworkView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import MultipeerConnectivity

class LocalNetworkManager: NSObject, ObservableObject {
    @Published var devices: [MCPeerID] = []
    private var session: MCSession!
    private var serviceAdvertiser: MCNearbyServiceAdvertiser!
    private var serviceBrowser: MCNearbyServiceBrowser!
    
    override init() {
        super.init()
        let peerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "file-transfer")
        serviceAdvertiser.delegate = self
        serviceAdvertiser.startAdvertisingPeer()
        
        serviceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: "file-transfer")
        serviceBrowser.delegate = self
        serviceBrowser.startBrowsingForPeers()
    }
    
    func sendFile(to peer: MCPeerID, fileURL: URL) {
        guard let session = session else {
            print("Session is not initialized.")
            return
        }
        
        do {
            let fileData = try Data(contentsOf: fileURL)
            try session.send(fileData, toPeers: [peer], with: .reliable)
        } catch {
            print("Failed to send file: \(error)")
        }
    }
}

extension LocalNetworkManager: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected to \(peerID.displayName)")
        case .connecting:
            print("Connecting to \(peerID.displayName)")
        case .notConnected:
            print("Disconnected from \(peerID.displayName)")
        @unknown default:
            print("Unknown state")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {}
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
    func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler(true)
    }
}

extension LocalNetworkManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }
}

extension LocalNetworkManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        DispatchQueue.main.async {
            self.devices.append(peerID)
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.devices.removeAll { $0 == peerID }
        }
    }
}

struct LocalNetworkView: View {
    @ObservedObject var localNetworkManager = LocalNetworkManager()
    @State private var isSelectingFile = false
    @State private var selectedFileURL: URL?
    
    var body: some View {
        VStack {
            if localNetworkManager.devices.isEmpty {
                Text("No devices found")
            } else {
                List(localNetworkManager.devices, id: \.self) { device in
                    Text(device.displayName)
                    Button("Send File") {
                        isSelectingFile = true
                    }
                }
            }
        }
        .sheet(isPresented: $isSelectingFile) {
            FilePicker { url in
                selectedFileURL = url
            }
        }
        .onChange(of: selectedFileURL) { url in
            guard let url = url, let selectedPeer = localNetworkManager.devices.first else { return }
            localNetworkManager.sendFile(to: selectedPeer, fileURL: url)
        }
    }
}

struct FilePicker: View {
    var onFileChosen: (URL) -> Void
    @State private var isPresented = true
    
    var body: some View {
        DocumentPicker(isPresented: $isPresented) { url in
            onFileChosen(url)
        }
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    var isPresented: Binding<Bool>
    var onDocumentPicked: (URL) -> Void
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let viewController = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        viewController.allowsMultipleSelection = false
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        // Update the view controller if needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker
        
        init(parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let url = urls.first {
                parent.onDocumentPicked(url)
                parent.isPresented.wrappedValue = false
            }
        }
    }
}

struct LocalNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNetworkView()
    }
}
