//
//  AlbumViewModel.swift
//  Assignment07
//
//  Created by Deepak Kaligotla on 11/05/25.
//

class AlbumViewModel {
    var albums: [Album] = []

    func fetchAlbums() async {
        do {
            self.albums = try await NetworkService.shared.getAllAlbums()
        } catch {
            print("Failed to fetch albums: \(error.localizedDescription)")
        }
    }
}
