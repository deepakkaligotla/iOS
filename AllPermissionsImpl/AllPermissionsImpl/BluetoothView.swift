//
//  BluetoothView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import CoreBluetooth

extension CBPeripheral: Identifiable {}

class BluetoothManager: NSObject, ObservableObject {
    @Published var bluetoothState = false
    @Published var bluetoothAllowed = false
    @Published var peripherals: [CBPeripheral] = []
    var centralManager: CBCentralManager?
    private var rssiThreshold: Int = -70
    private var outOfRangeDuration: TimeInterval = 5
    private var lastSeenTimestamps: [UUID: Date] = [:]
    private var timer: Timer?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        startTimer()
    }
    
    func requestBluetoothPermission() {
        if centralManager?.state == .poweredOn {
            self.bluetoothAllowed = true
            centralManager?.scanForPeripherals(withServices: nil, options: nil)
        } else {
            self.bluetoothAllowed = false
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            self.bluetoothState = true
        case .poweredOff:
            self.bluetoothState = false
        case .resetting:
            print("CBManager is resetting")
            return
        case .unauthorized:
            if #available(iOS 13.0, *) {
                switch central.authorization {
                case .denied:
                    print("You are not authorized to use Bluetooth")
                    self.bluetoothAllowed = false
                case .restricted:
                    self.bluetoothAllowed = false
                    print("Bluetooth is restricted")
                case .allowedAlways:
                    self.bluetoothAllowed = true
                    central.scanForPeripherals(withServices: nil, options: nil)
                    print("Bluetooth is on and authorized")
                default:
                    self.bluetoothAllowed = false
                    print("Unexpected authorization")
                }
            }
            return
        case .unknown:
            print("CBManager state is unknown")
            return
        case .unsupported:
            print("Bluetooth is not supported on this device")
            return
        @unknown default:
            print("A previously unknown central manager state occurred")
            return
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            peripherals.append(peripheral)
        }
        lastSeenTimestamps[peripheral.identifier] = Date()
    }
    
    func checkForOutOfRangeDevices() {
        let currentTime = Date()
        for (peripheralIdentifier, lastSeenTime) in lastSeenTimestamps {
            if currentTime.timeIntervalSince(lastSeenTime) > outOfRangeDuration {
                if let index = peripherals.firstIndex(where: { $0.identifier == peripheralIdentifier }) {
                    let peripheral = peripherals[index]
                    peripherals.remove(at: index)
                }
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            self.requestBluetoothPermission()
            self.checkForOutOfRangeDevices()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func connectToDevice(_ peripheral: CBPeripheral) {
        guard let centralManager = centralManager else {
            print("Central manager is nil.")
            return
        }
        
        centralManager.connect(peripheral, options: nil)
    }
}

struct BluetoothView: View {
    @ObservedObject var bluetoothManager = BluetoothManager()
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Bluetooth Permission & State").font(.headline)) {
                    if self.bluetoothManager.bluetoothState {
                        if self.bluetoothManager.bluetoothAllowed {
                            Text("Bluetooth is ON & permission granted")
                        } else {
                            Button("Grant Bluetooth Permission") {
                                self.bluetoothManager.requestBluetoothPermission()
                            }
                        }
                    } else {
                        Button {
                            if let bluetoothSettings = URL.init(string: "App-Prefs:root=Bluetooth") {
                                UIApplication.shared.open(bluetoothSettings, options: [:], completionHandler: nil)
                            }
                        } label: {
                            Text("Turn ON Bluetooth")
                        }
                    }
                }
                
                Section(header: Text("Available Bluetooth devices").font(.headline)) {
                    if self.bluetoothManager.bluetoothAllowed && self.bluetoothManager.bluetoothState {
                        ForEach(self.bluetoothManager.peripherals, id: \.identifier) { peripheral in
                            let displayName = peripheral.name ?? "Unknown"
                            let identifierString = peripheral.identifier.uuidString
                            let identifierParts = identifierString.components(separatedBy: "-")
                            let lastPart = identifierParts.last ?? ""
                            
                            Button(action: {
                                self.bluetoothManager.connectToDevice(peripheral)
                            }) {
                                Text("\(displayName) (\(lastPart))")
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            self.bluetoothManager.requestBluetoothPermission()
        }
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect to peripheral: \(peripheral), error: \(error?.localizedDescription ?? "Unknown error")")
    }
}

extension BluetoothManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error {
            print("Error discovering services for peripheral \(peripheral): \(error.localizedDescription)")
            return
        }
        
        guard let services = peripheral.services else {
            print("No services discovered for peripheral \(peripheral)")
            return
        }
        
        for service in services {
            print("Discovered service \(service)")
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let error = error {
            print("Error discovering characteristics for service \(service): \(error.localizedDescription)")
            return
        }
        
        guard let characteristics = service.characteristics else {
            print("No characteristics discovered for service \(service)")
            return
        }
        
        for characteristic in characteristics {
            print("Discovered characteristic \(characteristic)")
        }
    }
}

struct BluetoothView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothView()
    }
}
