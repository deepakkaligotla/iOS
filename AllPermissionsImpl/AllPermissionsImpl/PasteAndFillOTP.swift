//
//  Paste.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 13/04/24.
//

import SwiftUI
import Combine

struct PasteAndFillOTP: View {
    @State private var otp: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedTextFieldIndex: Int?
    @State private var deletePressedTwice = false
    let maxLength = 1
    
    var body: some View {
        VStack {
            LazyHGrid(rows: [GridItem(.fixed(40))]) {
                ForEach(0..<6, id: \.self) { index in
                    TextField("", text: $otp[index])
                        .frame(width: 40, height: 60)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                        .border(Color.white, width: 2)
                        .font(.title)
                        .keyboardType(.numberPad)
                        .onChange(of: otp[index]) { newValue in
                            if newValue.count > maxLength {
                                otp[index] = String(newValue.prefix(maxLength))
                            }
                            if !newValue.isEmpty && index < 5 {
                                DispatchQueue.main.async {
                                    focusedTextFieldIndex = index + 1
                                }
                            }
                            if newValue.isEmpty && index < 6 {
                                DispatchQueue.main.async {
                                    focusedTextFieldIndex = index - 1
                                }
                            }
                        }
                        .focused($focusedTextFieldIndex, equals: index)
                }
            }
        }
        .onAppear {
            if let clipboardString = UIPasteboard.general.string {
                let pattern = #"\b\d{6}\b"#
                do {
                    let regex = try NSRegularExpression(pattern: pattern)
                    let matches = regex.matches(in: clipboardString, range: NSRange(clipboardString.startIndex..., in: clipboardString))
                    if let match = matches.first {
                        let otpRange = Range(match.range, in: clipboardString)!
                        let otpString = String(clipboardString[otpRange])
                        if let otp = Int(otpString) {
                            let otpDigits = String(format: "%06d", otp).map { String($0) }
                            for (index, digit) in otpDigits.enumerated() {
                                self.otp[index] = digit
                            }
                        }
                    }
                } catch {
                    print("Error: Invalid regex pattern")
                }
            }
        }
    }
}

struct PasteAndFillOTP_Previews: PreviewProvider {
    static var previews: some View {
        PasteAndFillOTP()
    }
}
