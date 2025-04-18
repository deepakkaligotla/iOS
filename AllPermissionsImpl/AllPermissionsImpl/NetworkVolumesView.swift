//
//  NetworkVolumesView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 31/03/24.
//

import SwiftUI

struct NetworkVolumesView: View {
    @State private var networkVolumes: [String] = []
    
    var body: some View {
        if networkVolumes.isEmpty{
            Text("No Local Network Volumes found")
        } else {
            List(networkVolumes, id: \.self) { volume in
                Text(volume)
            }
            .onAppear {
                discoverNetworkVolumes()
            }
        }
    }
    
    private func discoverNetworkVolumes() {
        let fileManager = FileManager.default
        if let volumes = fileManager.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: []) {
            networkVolumes = volumes.compactMap { url in
                guard !url.hasDirectoryPath else { return nil }
                return url.path
            }
        }
    }
}

struct NetworkVolumesView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkVolumesView()
    }
}
