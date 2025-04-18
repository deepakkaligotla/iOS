//
//  TruckAndTrailerView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 14/08/24.
//

import SwiftUI

struct TruckAndTrailerView: View {
    @State private var showPopup = false
    @State private var popupMessage = ""
    @State private var isSuccess = false

    private func unassignTruck() {
        API.removeTruckFromDriverProfile(truckId: "12345") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let responseBody):
                    if let message = responseBody["message"] as? String, let status = responseBody["status"] as? String {
                        popupMessage = message
                        isSuccess = status == "success"
                    } else {
                        popupMessage = "Unexpected response format"
                        isSuccess = false
                    }
                case .failure(let error):
                    popupMessage = "Error: \(error.localizedDescription)"
                    isSuccess = false
                }
                showPopup = true
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        SectionView(title: "Truck & Trailer") {
                            ElevatedCard {
                                VStack(alignment: .center) {
                                    Text("Unit Numbers")
                                        .font(.headline)
                                    Text("888")
                                        .font(.largeTitle)
                                    Button(action: {
                                        unassignTruck()
                                    }) {
                                        Text("Unassign Truck")
                                            .foregroundColor(.red)
                                            .underline()
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity)
                    }
                    Spacer()
                }

                if showPopup {
                    VStack {
                        Spacer()
                        Text(popupMessage)
                            .padding()
                            .background(isSuccess ? Color.green : Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(radius: 10)
                            .transition(.opacity)
                            .frame(width: 300)
                            .animation(.easeInOut, value: showPopup)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    withAnimation {
                                        showPopup = false
                                    }
                                }
                            }
                        Spacer()
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Truck & Trailer")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }
}

#Preview {
    TruckAndTrailerView()
}
