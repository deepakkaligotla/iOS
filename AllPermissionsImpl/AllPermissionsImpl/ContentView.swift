//
//  ContentView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 19/04/24.
//

import SwiftUI
import SwiftData
import CoreLocation
import AppTrackingTransparency
import EventKit
import Contacts
import Photos
import CoreBluetooth
import CoreNFC
import Network
import CallKit
import Speech
import AVFoundation
import LocalAuthentication
import Intents
import UserNotifications
import HealthKit
import CoreMotion
import HomeKit
import MediaPlayer
import NearbyInteraction
import GameKit
import VideoSubscriberAccount

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isPopupPresented = false
    @State private var selectedPermission: PermissionModel?
    @Query private var selectedPermissions: [PermissionModel]
    
    let allPermissions: [PermissionModel] = [
        PermissionModel(name: "App Tracking Transparency", allowed: false),
        PermissionModel(name: "AppleTV", allowed: false),
        PermissionModel(name: "Bluetooth", allowed: false),
        PermissionModel(name: "Calendar", allowed: false),
        PermissionModel(name: "Camera", allowed: false),
        PermissionModel(name: "Contact", allowed: false),
        PermissionModel(name: "FaceID", allowed: false),
        PermissionModel(name: "File Manager", allowed: false),
        PermissionModel(name: "File Transfer", allowed: false),
        PermissionModel(name: "Focus", allowed: false),
        PermissionModel(name: "GameKit", allowed: false),
        PermissionModel(name: "Haptic Feedback", allowed: false),
        PermissionModel(name: "Health", allowed: false),
        PermissionModel(name: "HomeKit", allowed: false),
        PermissionModel(name: "Local Network", allowed: false),
        PermissionModel(name: "Location", allowed: false),
        PermissionModel(name: "Media & Apple Music", allowed: false),
        PermissionModel(name: "Microphone", allowed: false),
        PermissionModel(name: "Mirror Screen", allowed: false),
        PermissionModel(name: "NearBy", allowed: false),
        PermissionModel(name: "Network Details", allowed: false),
        PermissionModel(name: "Network Volumes", allowed: false),
        PermissionModel(name: "NFC", allowed: false),
        PermissionModel(name: "Notifications", allowed: false),
        PermissionModel(name: "Paste & Fill OTP", allowed: false),
        PermissionModel(name: "Photos", allowed: false),
        PermissionModel(name: "Reminders", allowed: false),
        PermissionModel(name: "Sensor", allowed: false),
        PermissionModel(name: "Siri", allowed: false),
        PermissionModel(name: "SMS", allowed: false),
        PermissionModel(name: "Speech", allowed: false),
        PermissionModel(name: "VoIP", allowed: false),
        PermissionModel(name: "Whatsapp", allowed: false)
    ]
    
    var body: some View {
        NavigationSplitView {
            Button(action: requestAllPermissions) {
                Text("All Permissions")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(Color.blue)
            .cornerRadius(8)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(selectedPermissions) { item in
                        NavigationLink(destination: destinationView(for: item.name)) {
                            ZStack {
                                Text(item.name)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .border(Color.black)
                            .background(item.allowed ? Color.green : Color.red)
                            .cornerRadius(8)
                            .contextMenu {
                                Button(action: {
                                    deleteItems(offsets: IndexSet([selectedPermissions.firstIndex(where: { $0.id == item.id })!]))
                                }) {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                
#endif
                ToolbarItem(placement: ToolbarItemPlacement.topBarTrailing) {
                    Button(action: {
                        isPopupPresented = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $isPopupPresented) {
                        PermissionListPopup(permissions: allPermissions.filter { !itemsContainsPermission($0.name) },
                                            isPresented: $isPopupPresented,
                                            didSelectPermission: { selectedPermission in
                            addItem(permission: selectedPermission)
                        })
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .onAppear(perform: checkAllPermissions)
    }
    
    private func itemsContainsPermission(_ permission: String) -> Bool {
        selectedPermissions.contains { $0.name == permission }
    }
    
    private func addItem(permission: PermissionModel) {
        withAnimation {
            let newItem = PermissionModel(name: permission.name, allowed: permission.allowed)
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(selectedPermissions[index])
            }
        }
    }
    
    private func destinationView(for permission: String) -> some View {
        switch permission {
        case "App Tracking Transparency": return AnyView(ATTView())
        case "AppleTV": return AnyView(AppleTVView())
        case "Bluetooth": return AnyView(BluetoothView())
        case "Calendar": return AnyView(CalendarView())
        case "Camera": return AnyView(CameraView())
        case "Contact": return AnyView(ContactView())
        case "FaceID": return AnyView(FaceIDView())
        case "File Manager": return AnyView(FileManagerView())
        case "File Transfer" : return AnyView(FileTransferView())
        case "Focus": return AnyView(FocusView())
        case "GameKit": return AnyView(GameKitView())
        case "Haptic Feedback": return AnyView(HapticFeedback())
        case "Health": return AnyView(HealthView())
        case "HomeKit": return AnyView(HomeKitView())
        case "Local Network": return AnyView(LocalNetworkView())
        case "Location": return AnyView(LocationView())
        case "Media & Apple Music": return AnyView(MediaAppleMusicView())
        case "Microphone": return AnyView(MicrophoneView())
        case "Mirror Screen": return AnyView(MirrorScreen())
        case "NearBy": return AnyView(NearbyView())
        case "NFC": return AnyView(NFCView())
        case "Network Details": return AnyView(NetworkDetailsView())
        case "Network Volumes": return AnyView(NetworkVolumesView())
        case "Notifications": return AnyView(NotificationsView())
        case "Paste & Fill OTP": return AnyView(PasteAndFillOTP())
        case "Photos": return AnyView(PhotosView())
        case "Reminders": return AnyView(RemindersView())
        case "Sensor": return AnyView(SensorView())
        case "Siri": return AnyView(SiriView())
        case "SMS": return AnyView(SMSView())
        case "Speech": return AnyView(SpeechView())
        case "VoIP": return AnyView(VoIPView())
        case "Whatsapp": return AnyView(WhatsappView())
        default: return AnyView(Text("No view found for permission: \(permission)"))
        }
    }
    
    private func checkAllPermissions() {
        DispatchQueue.main.async {
            allPermissions.indices.forEach { index in
                let permission = allPermissions[index]
                switch permission.name {
                case "App Tracking Transparency": permission.allowed = ATTrackingManager.trackingAuthorizationStatus == .authorized
                case "AppleTV" :
                    VSAccountManager().checkAccessStatus(options: [VSCheckAccessOption.prompt : true]) { (status, error) in
                        permission.allowed = status == .granted
                    }
                case "Bluetooth": permission.allowed = BluetoothManager().centralManager?.scanForPeripherals(withServices: nil, options: nil) != nil
                case "Calendar": permission.allowed = EKEventStore.authorizationStatus(for: .event) == .fullAccess
                case "Camera": permission.allowed = AVCaptureDevice.authorizationStatus(for: .video) == .authorized
                case "Contact": permission.allowed = CNContactStore.authorizationStatus(for: .contacts) == .authorized
                case "FaceID": 
                    if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: NSErrorPointer.none) {
                        permission.allowed = true
                    } else {
                        if LAContext().canEvaluatePolicy(.deviceOwnerAuthentication, error: NSErrorPointer.none) {
                            permission.allowed = true
                        } else {
                            permission.allowed = false
                        }
                    }
                case "File Manager" : permission.allowed = true
                case "File Transfer": permission.allowed = true
                case "Focus" : permission.allowed = INFocusStatusCenter.default.authorizationStatus == .authorized
                case "GameKit" : permission.allowed = GKLocalPlayer.local.isAuthenticated
                case "Haptic Feedback":
                    do {
                        let generator = UIImpactFeedbackGenerator(style: .soft)
                        generator.impactOccurred()
                        permission.allowed = true
                    } catch {
                        permission.allowed = false
                    }
                case "Health" :
                    HKHealthStore().getRequestStatusForAuthorization(toShare: [], read: MyHealth.healthTypes) { status, error in
                        permission.allowed = status == .unnecessary
                    }
                case "HomeKit" : permission.allowed = HMHomeManager().authorizationStatus == .authorized
                case "Local Network": permission.allowed = LocalNetworkView().localNetworkManager.devices.count >= 0
                case "Location": permission.allowed = CLLocationManager().authorizationStatus == .authorizedWhenInUse || CLLocationManager().authorizationStatus == .authorizedAlways
                case "Media & Apple Music" : permission.allowed = MPMediaLibrary.authorizationStatus() == .authorized
                case "Microphone": permission.allowed = AVAudioApplication.shared.recordPermission == AVAudioApplication.recordPermission.granted
                case "Mirror Screen": permission.allowed = true
                case "NearBy" : permission.allowed = NISession.isSupported
                case "NFC": permission.allowed = NFCTagReaderSession.readingAvailable
                case "Network Details": permission.allowed = true
                case "Network Volumes": permission.allowed = true
                case "Notifications" : UNUserNotificationCenter.current().getNotificationSettings { settings in
                    permission.allowed = settings.authorizationStatus == .authorized
                }
                case "Paste & Fill OTP": permission.allowed = UIPasteboard.general.string != nil
                case "Photos": permission.allowed = PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .limited
                case "Reminders": permission.allowed = EKEventStore.authorizationStatus(for: .reminder) == .fullAccess
                case "Sensor" : permission.allowed = CMMotionActivityManager.authorizationStatus() == .authorized
                case "Siri": permission.allowed = INPreferences.siriAuthorizationStatus() == .authorized
                case "Speech": permission.allowed = SFSpeechRecognizer.authorizationStatus() == .authorized
                case "VoIP": permission.allowed = CXCallObserver().calls.count >= 0
                default:
                    break
                }
            }
        }
    }
    
    private func requestAllPermissions() {
        ATTrackingManager.requestTrackingAuthorization { status in } //ATT
        VSAccountManager().checkAccessStatus(options: [VSCheckAccessOption.prompt : true]) { (status, error) in }//AppleTV
        BluetoothManager().requestBluetoothPermission() //Bluetooth
        EKEventStore().requestFullAccessToEvents { success, error in } //Calendar
        AVCaptureDevice.requestAccess(for: .video) { granted in } //Camera
        CNContactStore().requestAccess(for: .contacts) { success, error in } //Contact
        LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate with Face ID") { success, error in } //FaceID
        //All Folders
        //File Transfer
        INFocusStatusCenter.default.requestAuthorization { status in } //Focus
        GKLocalPlayer.local.authenticateHandler = { viewController, error in } //GameKit
        //HapticFeedback
        HKHealthStore().requestAuthorization(toShare: nil, read: MyHealth.healthTypes) { success, error in } //Health
        HMHomeManager().homes //HomeKit
        //Local Network
        CLLocationManager().requestAlwaysAuthorization() //Location
        MPMediaLibrary.requestAuthorization { status in } //Media & Apple Music
        AVAudioApplication.requestRecordPermission{ status in } //Microphone
        //Mirror Screen
        NISession.deviceCapabilities //NearBy
        NFCManager().startNFCTagReadingSession() //NFC
        do { try FileManager().contentsOfDirectory(atPath: "/Volumes") } catch { } //Network Volumes
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound, .provisional]) { granted, error in }
        //Notifications
        UIPasteboard.general.string //Pase & Fill OTP
        PHPhotoLibrary.requestAuthorization { status in } //Photos
        EKEventStore().requestFullAccessToReminders { success, error in } //Reminders
        CMMotionActivityManager().startActivityUpdates(to: .main) { activity in } //Sensor
        SFSpeechRecognizer.requestAuthorization { status in } //Speech
        INPreferences.requestSiriAuthorization { status in } //Siri
        CXCallObserver().calls.count //VoIP
        checkAllPermissions()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: PermissionModel.self, inMemory: true)
}
