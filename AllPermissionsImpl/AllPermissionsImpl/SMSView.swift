//
//  SMSView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 15/04/24.
//

import SwiftUI
import MessageUI
import SwiftData

struct SMSView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isShowingSBIMessageComposer = false
    @State private var isShowingICICIMessageComposer = false
    @State private var isShowingHDFCMessageComposer = false

    var body: some View {
        VStack {
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 40))]) {
                Button(action: {
                    self.isShowingSBIMessageComposer.toggle()
                }) {
                    Text("SBI Balance")
                }
                .sheet(isPresented: $isShowingSBIMessageComposer) {
                    MessageComposer(recipients: ["+919223766666"], body: "MODBAL")
                }
                
                Button(action: {
                    self.isShowingICICIMessageComposer.toggle()
                }) {
                    Text("ICICI Balance")
                }
                .sheet(isPresented: $isShowingICICIMessageComposer) {
                    MessageComposer(recipients: ["+919215676766"], body: "IBAL")
                }
                
                Button(action: {
                    self.isShowingHDFCMessageComposer.toggle()
                }) {
                    Text("HDFC Balance")
                }
                .sheet(isPresented: $isShowingHDFCMessageComposer) {
                    MessageComposer(recipients: ["5676712"], body: "bal")
                }
            }
        }
    }
}

struct MessageComposer: UIViewControllerRepresentable {
    typealias UIViewControllerType = MFMessageComposeViewController

    let recipients: [String]
    let body: String

    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let controller = MFMessageComposeViewController()
        controller.recipients = recipients
        controller.body = body
        controller.messageComposeDelegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true)
        }
    }
}

struct SMSView_Previews: PreviewProvider {
    static var previews: some View {
        SMSView()
    }
}
