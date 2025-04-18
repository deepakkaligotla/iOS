//
//  FileTransferView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 12/04/24.
//

import SwiftUI
import CocoaAsyncSocket

class FTPServer: NSObject, GCDAsyncSocketDelegate, ObservableObject {
    private var commandSocket: GCDAsyncSocket!
    private var dataSocket: GCDAsyncSocket?
    private var clients: [GCDAsyncSocket] = []
    private let commandPort: UInt16 = 2121  // Command port for FTP
    private let dataPort: UInt16 = 2122     // Data port for FTP (you can use a dynamic range for production)
    @Published var statusMessage: String = "Starting FTP server..."

    override init() {
        super.init()
        setupServer()
    }

    func setupServer() {
        commandSocket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        do {
            try commandSocket.accept(onPort: commandPort)
            statusMessage = "FTP server started on port \(commandPort)"
            print(statusMessage)
        } catch {
            statusMessage = "Error starting server: \(error.localizedDescription)"
            print(statusMessage)
        }
    }

    // MARK: - GCDAsyncSocketDelegate

    func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        clients.append(newSocket)
        print("New client connected: \(newSocket)")
        sendWelcomeMessage(to: newSocket)
        newSocket.readData(to: GCDAsyncSocket.crlfData(), withTimeout: -1, tag: 0)
    }

    func sendWelcomeMessage(to socket: GCDAsyncSocket) {
        let welcomeMessage = "220 Service ready for new user.\r\n"
        socket.write(welcomeMessage.data(using: .utf8), withTimeout: -1, tag: 0)
    }

    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        let command = String(data: data, encoding: .utf8) ?? ""
        print("Received command: \(command)")
        
        if command.hasPrefix("PORT") {
            handlePORTCommand(command, on: sock)
        } else if command.hasPrefix("PASV") {
            handlePASVCommand(on: sock)
        } else if command.hasPrefix("LIST") {
            handleLISTCommand(on: sock)
        } else {
            let response = "200 Command okay.\r\n"
            sock.write(response.data(using: .utf8), withTimeout: -1, tag: 0)
        }

        sock.readData(to: GCDAsyncSocket.crlfData(), withTimeout: -1, tag: 0)
    }

    func handlePORTCommand(_ command: String, on socket: GCDAsyncSocket) {
        let portData = command.split(separator: " ")[1].split(separator: ",")
        guard portData.count == 6,
              let p1 = UInt16(portData[4]),
              let p2 = UInt16(portData[5]) else {
            let response = "500 Syntax error.\r\n"
            socket.write(response.data(using: .utf8), withTimeout: -1, tag: 0)
            return
        }

        let port = (p1 << 8) + p2
        let dataSocket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        self.dataSocket = dataSocket
        do {
            try dataSocket.connect(toHost: "192.168.1.2", onPort: port)
            let response = "200 Command okay.\r\n"
            socket.write(response.data(using: .utf8), withTimeout: -1, tag: 0)
        } catch {
            let response = "425 Can't open data connection.\r\n"
            socket.write(response.data(using: .utf8), withTimeout: -1, tag: 0)
        }
    }

    func handlePASVCommand(on socket: GCDAsyncSocket) {
        let response = "227 Entering Passive Mode (192,168,1,2,\(dataPort >> 8),\(dataPort & 0xFF)).\r\n"
        socket.write(response.data(using: .utf8), withTimeout: -1, tag: 0)

        let dataSocket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        self.dataSocket = dataSocket
        do {
            try dataSocket.accept(onPort: dataPort)
        } catch {
            let errorResponse = "425 Can't open data connection.\r\n"
            socket.write(errorResponse.data(using: .utf8), withTimeout: -1, tag: 0)
        }
    }

    func handleLISTCommand(on socket: GCDAsyncSocket) {
        guard let dataSocket = self.dataSocket else {
            let response = "425 Can't open data connection.\r\n"
            socket.write(response.data(using: .utf8), withTimeout: -1, tag: 0)
            return
        }

        // Simulate a directory listing
        let directoryListing = "drwxr-xr-x 5 owner group 4096 Aug 4 12:34 example_directory\r\n"
        dataSocket.write(directoryListing.data(using: .utf8), withTimeout: -1, tag: 0)
        dataSocket.disconnect()
        
        let response = "226 Closing data connection.\r\n"
        socket.write(response.data(using: .utf8), withTimeout: -1, tag: 0)
    }

    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        if let index = clients.firstIndex(of: sock) {
            clients.remove(at: index)
        }
        print("Client disconnected: \(sock), Error: \(err?.localizedDescription ?? "None")")
    }
}

struct FileTransferView: View {
    @StateObject private var ftpServer = FTPServer()
    
    var body: some View {
        VStack {
            Text(ftpServer.statusMessage)
                .padding()
            Spacer()
        }
        .onAppear {
            ftpServer.setupServer()
        }
    }
}

struct FileTransferView_Previews: PreviewProvider {
    static var previews: some View {
        FileTransferView()
    }
}
