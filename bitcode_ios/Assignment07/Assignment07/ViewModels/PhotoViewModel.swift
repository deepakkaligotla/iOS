//
//  PhotoViewModel.swift
//  Assignment07
//
//  Created by Deepak Kaligotla on 11/05/25.
//

class PhotoViewModel {
    var photos: [Photo] = []

    func fetchPhotos() async {
        do {
            self.photos = try await NetworkService.shared.getAllPhotos()
        } catch {
            print("Failed to fetch photos: \(error.localizedDescription)")
        }
    }
}
