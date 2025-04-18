//
//  NetworkDetailsView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 30/04/24.
//

import SwiftUI
import Network

struct NetworkDetailsView: View {
    @State private var isConnectedViaWiFi = false
    @State private var publicIP = "Loading..."
    @State private var localIPv4 = "Loading..."
    @State private var localIPv6 = "Loading..."
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Connected via").font(.headline)) {
                    if isConnectedViaWiFi {
                        Text("Wi-Fi")
                    } else {
                        Text("Mobile Data")
                    }
                }
                
                Section(header: Text("Public IP").font(.headline)) {
                    Text(publicIP)
                }
                
                Section(header: Text("Local IPv4").font(.headline)) {
                    Text(localIPv4)
                }
                
                Section(header: Text("Local IPv6").font(.headline)) {
                    Text(localIPv6)
                }
            }
        }
        .onAppear {
            checkConnectivity()
            fetchPublicIP()
            fetchLocalIP()
        }
        .onChange(of: self.isConnectedViaWiFi) {
            fetchPublicIP()
            fetchLocalIP()
        }
    }
    
    private func checkConnectivity() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnectedViaWiFi = path.usesInterfaceType(.wifi)
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    private func fetchPublicIP() {
        guard let url = URL(string: "https://api.ipify.org") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching public IP:", error ?? "Unknown error")
                return
            }
            
            if let ip = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.publicIP = ip
                }
            }
        }.resume()
    }
    
    private func fetchLocalIP() {
        var ipv4Address: String?
        var ipv6Address: String?
        
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                guard let interface = ptr?.pointee else { return }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                // wifi = ["en0"]
                // wired = ["en2", "en3", "en4"]
                // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
                if addrFamily == UInt8(AF_INET) {
                    let name: String = String(cString: (interface.ifa_name))
                    if self.isConnectedViaWiFi {
                        if name == "en0" {
                            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                            if getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0 {
                                ipv4Address = String(cString: hostname)
                            }
                        }
                    } else {
                        if name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                            if getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0 {
                                ipv4Address = String(cString: hostname)
                            }
                        }
                    }
                } else if addrFamily == UInt8(AF_INET6) {
                    let name: String = String(cString: (interface.ifa_name))
                    if self.isConnectedViaWiFi {
                        if name == "en0" {
                            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                            if getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0 {
                                ipv6Address = String(cString: hostname)
                            }
                        }
                    } else {
                        if name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                            if getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0 {
                                ipv6Address = String(cString: hostname)
                            }
                        }
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        if let finalIPv4Address = ipv4Address {
            DispatchQueue.main.async {
                self.localIPv4 = finalIPv4Address
            }
        }
        
        if let finalIPv6Address = ipv6Address {
            DispatchQueue.main.async {
                self.localIPv6 = finalIPv6Address
            }
        }
    }
}

struct NetworkDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkDetailsView()
    }
}
