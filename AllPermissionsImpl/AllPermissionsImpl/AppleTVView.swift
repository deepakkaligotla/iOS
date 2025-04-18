//
//  AppleTVView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import VideoSubscriberAccount

struct AppleTVView: View {
    @State var appleTVAllowed = false
    
    var body: some View {
        VStack {
            if appleTVAllowed {
                Text("Apple TV Permission allowed")
            } else {
                Button {
                    checkAppleTVPermission()
                } label: {
                    Text("Grant Apple TV Permission")
                }
            }
        }
        .onAppear {
            checkAppleTVPermission()
        }
    }
    
    func checkAppleTVPermission() {
        VSAccountManager().checkAccessStatus(options: [VSCheckAccessOption.prompt : true]) { (status, error) in
            self.appleTVAllowed = status == .granted
        }
    }
}

struct AppleTVView_Previews: PreviewProvider {
    static var previews: some View {
        AppleTVView()
    }
}
