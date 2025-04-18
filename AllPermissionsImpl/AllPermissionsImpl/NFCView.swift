//
//  NFCView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 30/03/24.
//

import SwiftUI
import CoreNFC

extension NFCNDEFReaderSession: Identifiable {
    public var id: Int { hashValue }
}

class NFCManager: NSObject, ObservableObject {
    @Published var nfcSessions: [NFCNDEFReaderSession] = []
    @Published var detectedMessages: [NFCNDEFMessage] = []

    func startNFCTagReadingSession() {
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session.begin()
        nfcSessions.append(session)
    }
}

struct DetectedMessageItem: Identifiable {
    let id: Int
    let message: NFCNDEFMessage
}

struct NFCView: View {
    @ObservedObject var nfcManager = NFCManager()
    @State private var selectedMessage: DetectedMessageItem?

    var body: some View {
        VStack {
            if NFCTagReaderSession.readingAvailable {
                if nfcManager.nfcSessions.isEmpty {
                    Text("NFC available, but no NFC devices found")
                } else {
                    List(nfcManager.nfcSessions) { session in
                        Button(action: {
                            session.begin()
                        }) {
                            Text("NFC Session: \(session.id)")
                        }
                    }
                }
            } else {
                Text("NFC not available in this Device")
            }
        }
        .sheet(item: $selectedMessage) { item in
            Text("Detected NDEF Message: \(item.message)")
        }
        .onAppear {
            if NFCTagReaderSession.readingAvailable {
                nfcManager.startNFCTagReadingSession()
            }
        }
        .onReceive(nfcManager.$detectedMessages) { messages in
            if let firstMessage = messages.first {
                selectedMessage = DetectedMessageItem(id: 0, message: firstMessage)
            }
        }
    }
}

extension NFCManager: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        DispatchQueue.main.async {
            self.detectedMessages.append(contentsOf: messages)
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
            if tags.count > 1 {
                let retryInterval = DispatchTimeInterval.milliseconds(500)
                session.alertMessage = "More than 1 tag is detected. Please remove all tags and try again."
                DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                    session.restartPolling()
                })
                return
            }
            
            let tag = tags.first!
            session.connect(to: tag, completionHandler: { (error: Error?) in
                if nil != error {
                    session.alertMessage = "Unable to connect to tag."
                    session.invalidate()
                    return
                }
                
                tag.queryNDEFStatus(completionHandler: { (ndefStatus: NFCNDEFStatus, capacity: Int, error: Error?) in
                    guard error == nil else {
                        session.alertMessage = "Unable to query the NDEF status of tag."
                        session.invalidate()
                        return
                    }


                    switch ndefStatus {
                    case .notSupported:
                        session.alertMessage = "Tag is not NDEF compliant."
                        session.invalidate()
                    case .readOnly:
                        session.alertMessage = "Tag is read only."
                        session.invalidate()
                    case .readWrite:
                        tag.writeNDEF(self.detectedMessages.first!, completionHandler: { (error: Error?) in
                            if nil != error {
                                session.alertMessage = "Write NDEF message fail: \(error!)"
                            } else {
                                session.alertMessage = "Write NDEF message successful."
                            }
                            session.invalidate()
                        })
                    @unknown default:
                        session.alertMessage = "Unknown NDEF tag status."
                        session.invalidate()
                    }
                })
            })
        }

        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            if let readerError = error as? NFCReaderError {
                if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                    && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                    
                }
            }
        }

        func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {

        }
}

struct NFCView_Previews: PreviewProvider {
    static var previews: some View {
        NFCView()
    }
}
