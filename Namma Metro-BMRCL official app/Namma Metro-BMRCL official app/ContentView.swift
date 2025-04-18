//
//  ContentView.swift
//  Namma Metro-BMRCL official app
//
//  Created by Deepak Kaligotla on 06/08/24.
//

import SwiftUI
import SwiftData
import MapKit

struct ContentView: View {
    @StateObject private var metroDataLoader = MetroDataLoader()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    var body: some View {
        MapView(stations: metroDataLoader.metroStations, region: $region)
            .edgesIgnoringSafeArea(.all)
    }
}

struct MapPolyline: MapOverlay {
    var coordinates: [CLLocationCoordinate2D]
    
    func makeOverlay(mapView: MKMapView) -> MKOverlay {
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        return polyline
    }
}

protocol MapOverlay {
    var coordinates: [CLLocationCoordinate2D] { get }
    func makeOverlay(mapView: MKMapView) -> MKOverlay
}

#Preview {
    ContentView()
        .modelContainer(for: MetroStation.self, inMemory: true)
}
