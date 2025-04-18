//
//  SideMenuView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

//
//  SideMenuView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI

struct SideMenuView: View {
    @Environment(\.colorScheme) var colorScheme
    var isDarkMode: Bool {
        return colorScheme == .dark
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                
                Section(header: StickyHeader(title: "Inertial Sensors")) {
                    VStack {
                        MenuItem(imageName: "pedal.accelerator", title: "Accelerometer", destination: AccelerometerView())
                        MenuItem(imageName: "gyroscope", title: "Gyroscope", destination: GyroscopeView())
                        MenuItem(imageName: "figure.fall", title: "Gravity", destination: GravityView())
                        MenuItem(imageName: "cursorarrow.motionlines.click", title: "Attitude", destination: AttitudeView())
                        MenuItem(imageName: "figure.fall", title: "Fall Detection", destination: FallDetectionView())
                        MenuItem(imageName: "beats.headphones", title: "Headphone Motion", destination: HeadphoneMotionView())
                        MenuItem(imageName: "figure.walk.motion", title: "Motion Acitivity", destination: MotionActivityView())
                        MenuItem(imageName: "figure.walk", title: "Movement Disorder", destination: MovementDisorderView())
                        MenuItem(imageName: "gearshift.layout.sixspeed", title: "Speedometer", destination: SpeedometerView())
                        MenuItem(imageName: "figure.stair.stepper", title: "Step Counter", destination: StepCounterView())
                        MenuItem(imageName: "pedestrian.gate.open", title: "Pedometer", destination: PedometerView())
                    }
                    .padding(.horizontal, 20)
                }
                Divider().background(Color.green)
                
                Section(header: StickyHeader(title: "Non-Inertial Sensors")) {
                    VStack {
                        MenuItem(imageName: "alt", title: "Altimeter", destination: AltimeterView())
                        MenuItem(imageName: "light.max", title: "Ambient Light", destination: AmbientLightView())
                        MenuItem(imageName: "tirepressure", title: "Ambient Pressure", destination: AmbientPressureView())
                        MenuItem(imageName: "alt", title: "Magnetometer", destination: MagnetometerView())
                        MenuItem(imageName: "barometer", title: "Barometer", destination: BarometerView())
                        MenuItem(imageName: "location.viewfinder", title: "Location", destination: LocationView())
                        MenuItem(imageName: "location.magnifyingglass", title: "Visits", destination: VisitsView())
                        MenuItem(imageName: "bolt.heart", title: "Heart Rate", destination: HeartRateView())
                        MenuItem(imageName: "hand.thumbsup", title: "Wrist Motion", destination: WristMotionView())
                    }
                    .padding(.horizontal, 20)
                }
                Divider()
                
                Section(header: StickyHeader(title: "Device Properties & Usage Reports")) {
                    VStack {
                        MenuItem(imageName: "exclamationmark.bubble", title: "Device Usage", destination: DeviceView())
                        MenuItem(imageName: "message.badge", title: "Message", destination: MessageView())
                        MenuItem(imageName: "phone.connection", title: "Phone", destination: PhoneView())
                        MenuItem(imageName: "keyboard.badge.eye", title: "Keyboard Metrics", destination: KeyboardMetricsView())
                        MenuItem(imageName: "alt", title: "Siri Speech Metrics", destination: SiriSpeechMetricsView())
                        MenuItem(imageName: "teletype.answer", title: "Telephony Speech Metrics", destination: TelephonySpeechMetricsView())
                    }
                    .padding(.horizontal, 20)
                }
                Divider()
                
                Section(header: StickyHeader(title: "Media Events")) {
                    VStack {
                        MenuItem(imageName: "tv.and.mediabox", title: "Media Events", destination: MediaEventsView())
                    }
                    .padding(.horizontal, 20)
                }
                Divider()
                
                Section(header: StickyHeader(title: "Miscellaneous")) {
                    VStack(spacing: 15) {
                        MenuItem(imageName: "globe.central.south.asia", title: "Altitude", destination: AltitudeView())
                        MenuItem(imageName: "rotate.3d", title: "Orientation", destination: OrientationView())
                    }
                    .padding(.horizontal, 20)
                }
                Spacer()
            }
            .foregroundColor(isDarkMode ? Color.black: Color.white)
            .background(isDarkMode ? Color.white: Color.black)
            .padding(.top, 80)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct StickyHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title3)
            .bold(true)
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MenuItem<Destination: View>: View {
    let imageName: String
    let title: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                Spacer()
                Text(title)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Spacer()
            }
        }
        Divider().background(Color.blue).frame(width: 240)
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SideMenuView()
}
