//
//  MetroDataLoader.swift
//  Namma Metro-BMRCL official app
//
//  Created by Deepak Kaligotla on 06/08/24.
//

import SwiftUI

class MetroDataLoader: ObservableObject {
    @Published var metroStations: [MetroStation] = []

    init() {
        loadGeoJSON()
    }

    func loadGeoJSON() {
        guard let url = Bundle.main.url(forResource: "metro-lines-stations", withExtension: "geojson") else {
            print("GeoJSON file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let stationsData = try decoder.decode(MetroStations.self, from: data)
            metroStations = stationsData.features
        } catch {
            print("Error decoding GeoJSON: \(error)")
        }
    }
}
