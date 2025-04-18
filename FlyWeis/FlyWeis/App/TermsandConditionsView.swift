//
//  TermsandConditionsView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 08/08/24.
//

import SwiftUI

struct TermsandConditionsView: View {
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    Text("Terms & Conditions")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("Last updated on: \(Date().description(with: .current))")
                        .font(.subheadline)
                    
                    Text(termsAndConditionsText)
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

private let termsAndConditionsText = """
    1. Introduction
    Welcome to [App Name]!

    These Terms and Conditions ("Terms", "Terms and Conditions") govern your relationship with [App Name] mobile application (the "Service") operated by [Your Company Name] ("us", "we", or "our").

    Please read these Terms and Conditions carefully before using our Service.

    2. Accounts
    When you create an account with us, you must provide us with information that is accurate, complete, and current at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account on our Service.

    You are responsible for safeguarding the password that you use to access the Service and for any activities or actions under your password, whether your password is with our Service or a third-party service.

    3. Links to Other Websites
    Our Service may contain links to third-party websites or services that are not owned or controlled by [Your Company Name].

    [Your Company Name] has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third-party websites or services.

    4. Termination
    We may terminate or suspend access to our Service immediately, without prior notice or liability, for any reason whatsoever, including, without limitation, if you breach the Terms.

    5. Governing Law
    These Terms shall be governed and construed in accordance with the laws of [Your State/Country], without regard to its conflict of law provisions.

    6. Changes
    We reserve the right, at our sole discretion, to modify or replace these Terms at any time.

    By continuing to access or use our Service after those revisions become effective, you agree to be bound by the revised terms.

    7. Contact Us
    If you have any questions about these Terms, please contact us at [Your Contact Information].
    """

#Preview {
    TermsandConditionsView()
}
