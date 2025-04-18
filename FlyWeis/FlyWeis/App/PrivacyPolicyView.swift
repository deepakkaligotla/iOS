//
//  PrivacyPolicyView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 08/08/24.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Privacy Policy")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                ScrollView {
                    Text(privacyPolicyText)
                        .font(.body)
                        .padding()
                }
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding()
        }
    }
}

private let privacyPolicyText = """
    Your privacy policy text goes here. This is a placeholder text that should be replaced with your actual privacy policy.
    Make sure to cover all aspects of your privacy practices, including data collection, usage, and sharing policies.

    - Data Collection: Describe what data is collected from users.
    - Usage: Explain how the collected data is used.
    - Sharing: Clarify if and how the data is shared with third parties.
    - Security: Outline the measures taken to protect user data.
    - User Rights: Inform users about their rights regarding their data.

    Update this text to fit your specific privacy policy requirements.
    """

#Preview {
    PrivacyPolicyView()
}

