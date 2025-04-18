//
//  MoreView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 09/08/24.
//

import SwiftUI

struct MoreView: View {
    @StateObject private var orientationObserver = OrientationObserver()
    @StateObject private var accelerometerObserver = CMAccelerometerObserver()
    @StateObject private var gyroscopeObserver = GyroscopeObserver()
    
    private var orientationDescription: String {
        switch orientationObserver.orientation {
        case .landscapeLeft:
            return "Landscape Left"
        case .landscapeRight:
            return "Landscape Right"
        case .portrait:
            return "Portrait"
        case .portraitUpsideDown:
            return "Portrait Upside Down"
        case .faceDown:
            return "FaceDown"
        case .faceUp:
            return "FaceUp"
        case .unknown:
            return "Unknown orientation"
        @unknown default:
            return "FatalError \(orientationObserver.orientation.rawValue)"
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .center) {
                    Text("John Deo").font(.title).bold()
                    Divider().frame(height: 2).background(Color.gray)
                    ScrollView {
                        HStack {
                            SectionView(title: "Rotation") {
                                ElevatedCard {
                                    Button(action: {
                                        print("Icon button tapped")
                                    }) {
                                        VStack {
                                            Image(systemName: orientationObserver.orientation.isPortrait ? "rectangle.landscape.rotate" : "rectangle.portrait.rotate")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(Color(red: 52/255, green: 183/255, blue: 193/255))
                                            Text("Rotation").font(.title3)
                                            HStack {
                                                Text("Accelerometer -").font(.caption2)
                                                Spacer()
                                                Text("X: \(String(format: "%.2f", accelerometerObserver.x)), Y: \(String(format: "%.2f", accelerometerObserver.y)), Z: \(String(format: "%.2f", accelerometerObserver.z))").font(.caption)
                                            }
                                            HStack {
                                                Text("Gyroscope -").font(.caption2)
                                                Spacer()
                                                Text("X: \(String(format: "%.2f", gyroscopeObserver.rotationX)), Y: \(String(format: "%.2f", gyroscopeObserver.rotationY)), Z: \(String(format: "%.2f", gyroscopeObserver.rotationZ))").font(.caption)
                                            }
                                            HStack {
                                                Text("Orientation -").font(.caption)
                                                Spacer()
                                                Text(orientationDescription).font(.caption)
                                            }
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .frame(width: 240, height:100)
                                }
                            }
                            SectionView(title: "Updates") {
                                ElevatedCard {
                                    Button(action: {
                                        print("Icon button tapped")
                                    }) {
                                        VStack {
                                            Image(systemName: "square.and.arrow.down")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(Color(red: 52/255, green: 183/255, blue: 193/255))
                                            Text("Updates").font(.title3)
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .frame(width: 100, height:100)
                                }
                            }
                        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        Spacer()
                        HStack {
                            VStack {
                                SectionView(title: "DOT Log Transfer") {
                                    ElevatedCard {
                                        Button(action: {
                                            print("Icon button tapped")
                                        }) {
                                            HStack {
                                                Image(systemName: "staroflife.shield")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color(red: 52/255, green: 183/255, blue: 193/255))
                                                Text("DOT Log Transfer").font(.title3).padding()
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .frame(height: 50)
                                    }
                                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                
                                SectionView(title: "Truck & Trailer") {
                                    ElevatedCard {
                                        NavigationLink(destination: TruckAndTrailerView()) {
                                            HStack {
                                                Image(systemName: "truck.box")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color(red: 52/255, green: 183/255, blue: 193/255))
                                                Text("Truck & Trailer")
                                                    .font(.title3)
                                                    .padding()
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .frame(height: 50)
                                    }
                                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                
                                SectionView(title: "Exemption") {
                                    ElevatedCard {
                                        Button(action: {
                                            print("Icon button tapped")
                                        }) {
                                            HStack {
                                                Image(systemName: "exclamationmark.circle")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color(red: 52/255, green: 183/255, blue: 193/255))
                                                Text("Exemption").font(.title3).padding()
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .frame(height: 50)
                                    }
                                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                
                                SectionView(title: "Cycle Information") {
                                    ElevatedCard {
                                        Button(action: {
                                            print("Icon button tapped")
                                        }) {
                                            HStack {
                                                Image(systemName: "arrow.3.trianglepath")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color(red: 52/255, green: 183/255, blue: 193/255))
                                                Text("Cycle Information").font(.title3).padding()
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .frame(height: 50)
                                    }
                                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                
                                SectionView(title: "Carrier Information") {
                                    ElevatedCard {
                                        Button(action: {
                                            print("Icon button tapped")
                                        }) {
                                            HStack {
                                                Image(systemName: "person.2.badge.gearshape")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color(red: 52/255, green: 183/255, blue: 193/255))
                                                Text("Carrier Information").font(.title3).padding()
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .frame(height: 50)
                                    }
                                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                
                                SectionView(title: "App Settings") {
                                    ElevatedCard {
                                        Button(action: {
                                            print("Icon button tapped")
                                        }) {
                                            HStack {
                                                Image(systemName: "gearshape")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color(red: 52/255, green: 183/255, blue: 193/255))
                                                Text("App Settings").font(.title3).padding()
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .frame(height: 50)
                                    }
                                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                
                                SectionView(title: "Logout") {
                                    ElevatedCard {
                                        Button(action: {
                                            print("Icon button tapped")
                                        }) {
                                            HStack {
                                                Image(systemName: "power")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color.red)
                                                Text("Logout").font(.title3).padding().foregroundColor(.red)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .frame(height: 50)
                                    }
                                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            }
                        }
                        Spacer()
                        HStack {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .background(Color(red: 52/255, green: 183/255, blue: 193/255))
                                .clipShape(Circle())
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.top, 10)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MoreView()
}
