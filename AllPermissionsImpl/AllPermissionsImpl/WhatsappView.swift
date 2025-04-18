//
//  WhatsappView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 17/07/24.
//

import SwiftUI

struct WhatsappView: View {
    @State private var whatsappNum: [String] = Array(repeating: "", count: 10)
    @FocusState private var focusedTextFieldIndex: Int?
    @State private var deletePressedTwice = false
    let maxLength = 1
    
    var body: some View {
        NavigationView {
            HStack(alignment: .top, spacing: 0) {
                VStack {
                    LazyHGrid(rows: [GridItem(.fixed(0))]) {
                        ForEach(0..<10, id: \.self) { index in
                            TextField("", text: $whatsappNum[index])
                                .frame(width: 30, height: 60)
                                .multilineTextAlignment(.center)
                                .textFieldStyle(.roundedBorder)
                                .border(Color.white, width: 2)
                                .font(.title)
                                .keyboardType(.numberPad)
                                .onChange(of: whatsappNum[index]) { newValue in
                                    if newValue.count > maxLength {
                                        whatsappNum[index] = String(newValue.prefix(maxLength))
                                    }
                                    if !newValue.isEmpty && index < 9 {
                                        DispatchQueue.main.async {
                                            focusedTextFieldIndex = index + 1
                                        }
                                    }
                                    if newValue.isEmpty && index < 10 {
                                        DispatchQueue.main.async {
                                            focusedTextFieldIndex = index - 1
                                        }
                                    }
                                }
                                .focused($focusedTextFieldIndex, equals: index)
                        }
                    }
                    Text("\u{f232}").font(.custom("Font Awesome 6 Brands", size: 72))
                        .onTapGesture {
                            let whatsappURL = URL(string: "https://wa.me/91\(whatsappNum.joined(separator: ""))")!
                            if UIApplication.shared.canOpenURL(whatsappURL) {
                                UIApplication.shared.open(whatsappURL)
                            } else {
                                print("Unable to open WhatsApp")
                            }
                        }
                }
            }
        }
    }
}
