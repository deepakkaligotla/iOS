//
//  HomeView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 09/08/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showNotification = false
    @State private var iconPosition: CGPoint = .zero
    @State private var iconSize: CGSize = .zero
    private var vehicleIdentificationNumber = "5YJSA1DG9DFP14705"
    private var truckName = "John's"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Spacer()
                        
                        HStack(alignment: .center) {
                            Button(action: {
                                print("Icon button tapped")
                            }) {
                                Image(systemName: "arrow.clockwise")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(red: 52/255, green: 183/255, blue: 193/255))
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Button(action: {
                                withAnimation {
                                    showNotification.toggle()
                                }
                            }) {
                                Image(systemName: "bell.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .background(
                                        GeometryReader { geo in
                                            Color.clear
                                                .onAppear {
                                                    iconPosition = geo.frame(in: .global).origin
                                                    iconSize = geo.size
                                                }
                                        }
                                    )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    Spacer()
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            SectionView(title: "Welcome Message") {
                                ElevatedCard {
                                    VStack(alignment: .center) {
                                        Text("John Doe").font(.title2).bold(true).padding()
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text("VIN  : \(vehicleIdentificationNumber)").font(.footnote).bold(true)
                                                Text("Truck: \(truckName)").font(.footnote).bold(true)
                                            }.padding()
                                            Spacer()
                                            Text("Status: Disconnected").font(.footnote).bold(true).padding()
                                        }
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(red: 35/255, green: 127/255, blue: 134/255),
                                                    Color(red: 35/255, green: 127/255, blue: 134/255)
                                                ]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                    }
                                }.padding()
                            }
                            
                            SectionView(title: "HOS info") {
                                ElevatedCard {
                                    VStack(alignment: .center) {
                                        HOSOptionsView()
                                        HStack(spacing: 8) {
                                            VStack {
                                                Text("Cycle Left").font(.headline).padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0))
                                                Text("70:00")
                                                Text("8 Days").font(.caption2)
                                            }
                                            Divider().background(Color.white).frame(width: 8)
                                            VStack {
                                                Text("Violations").font(.headline).padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
                                                Text("201")
                                            }
                                            Divider().background(Color.white)
                                            VStack {
                                                Text("Drive Left").font(.headline).padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
                                                Text("11:00")
                                            }
                                            Divider().background(Color.white)
                                            VStack {
                                                Text("Shift Left").font(.headline).padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
                                                Text("14:00")
                                            }
                                        }.padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                                        
                                        NavigationLink(destination: HOSInfoView()) {
                                            HStack {
                                                Text("HOS Info")
                                                    .bold()
                                                    .font(.title3)
                                                    .foregroundColor(.white)
                                                Image(systemName: "info.circle")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(.white)
                                            }
                                            .padding()
                                            .background(Color(red: 49/255, green: 146/255, blue: 119/255))
                                            .cornerRadius(10)
                                        }
                                    }
                                }
                            }
                            
                            SectionView(title: "Buttons4") {
                                HStack {
                                    Button(action: {
                                        
                                    }) {
                                        Text("D").font(.title2).padding().foregroundColor(.white)
                                    }
                                    .frame(width: geometry.size.width/5)
                                    .background(Color(red:30/255, green: 190/255, blue: 182/255))
                                    .cornerRadius(12)
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                    }) {
                                        Text("ON").font(.title2).padding().foregroundColor(.white)
                                    }
                                    .frame(width: geometry.size.width/5)
                                    .background(Color(red:214/255, green: 233/255, blue: 228/255))
                                    .cornerRadius(12)
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                    }) {
                                        Text("OFF").font(.title2).padding().foregroundColor(.white)
                                    }
                                    .frame(width: geometry.size.width/5)
                                    .background(Color(red:242/255, green: 217/255, blue: 216/255))
                                    .cornerRadius(12)
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                    }) {
                                        Text("SB").font(.title2).padding().foregroundColor(.white)
                                    }
                                    .frame(width: geometry.size.width/5)
                                    .background(Color(red:218/255, green: 246/255, blue: 255/255))
                                    .cornerRadius(12)
                                    Spacer()
                                }
                            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                            
                            SectionView(title: "Buttons2") {
                                HStack {
                                    ElevatedCard {
                                        Button(action: {
                                            
                                        }) {
                                            Text("Personal Use").font(.title3)
                                                .padding()
                                                .foregroundColor(.white)
                                        }
                                        .frame(width: geometry.size.width/3, height: 100)
                                        .cornerRadius(12)
                                    }
                                    ElevatedCard {
                                        Button(action: {
                                            
                                        }) {
                                            Text("Yard Move").font(.title3)
                                                .padding()
                                                .foregroundColor(.white)
                                        }
                                        .frame(width: geometry.size.width/3, height: 100)
                                        .cornerRadius(12)
                                    }
                                }
                            }
                            
                            SectionView(title: "Graph") {
                                VStack {
                                    HStack {
                                        Text("Today: \(formattedDateString())").font(.title2).padding()
                                        Spacer()
                                        Button(action: {
                                            
                                        }) {
                                            Text("Sign")
                                                .bold(true)
                                                .font(.title3)
                                                .foregroundColor(.white)
                                            Image(systemName: "exclamationmark.warninglight.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(.orange)
                                        }.buttonStyle(BorderedButtonStyle())
                                            .background(Color.clear)
                                            .cornerRadius(10)
                                    }
                                    GraphView()
                                }
                            }.padding()
                        }
                    }
                }
                
                if showNotification {
                    NotificationView(isShowing: $showNotification)
                        .frame(width: 250)
                        .background(Color.clear)
                        .position(x: min(max(iconPosition.x + iconSize.width / 2, 125), geometry.size.width - 125),
                                  y: min(max(iconPosition.y + iconSize.height + 30 + 50, 50), geometry.size.height - 50))
                        .onTapGesture {
                            //Open selected notification
                        }
                        .background(
                            Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation {
                                        showNotification = false
                                    }
                                }
                        )
                        .zIndex(1)
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
    
    func formattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd (E)" // Set the desired format
        let today = Date()
        return dateFormatter.string(from: today)
    }
}

#Preview {
    HomeView()
}
