//
//  ATTView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport

struct ATTView: View {
    @State private var advertisingIdentifier: String?
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("ATT Permission").font(.headline)) {
                    if ATTrackingManager.trackingAuthorizationStatus == .authorized {
                        Text("ATT Permission Granted")
                    } else {
                        Button(action: {
                            ATTrackingManager.requestTrackingAuthorization { status in }
                        }) {
                            Text("Request ATT Permission")
                        }
                    }
                }
                
                Section(header: Text("ATT ID").font(.headline)) {
                    if ATTrackingManager.trackingAuthorizationStatus == .authorized {
                        if let idfa = advertisingIdentifier {
                            Text("Advertising Identifier (IDFA): \(idfa)")
                        } else {
                            Text("Fetching IDFA...")
                                .onAppear {
                                    self.advertisingIdentifier = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                                }
                        }
                    }
                }
            }
        }
    }
}

struct ATTView_Previews: PreviewProvider {
    static var previews: some View {
        ATTView()
    }
}
