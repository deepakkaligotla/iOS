//
//  MapView.swift
//  Namma Metro-BMRCL official app
//
//  Created by Deepak Kaligotla on 06/08/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var stations: [MetroStation]
    @Binding var region: MKCoordinateRegion

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = region
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)

        let annotations = stations.map { station in
            let annotation = MKPointAnnotation()
            annotation.coordinate = station.coordinates.first?.CLLocationCoordinate2D ?? CLLocationCoordinate2D()
            annotation.title = station.name
            return annotation
        }
        
        mapView.addAnnotations(annotations)
        
        for station in stations {
            let coordinates = station.coordinates.map { $0.CLLocationCoordinate2D }
            let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            mapView.addOverlay(polyline)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(overlay: polyline)
                renderer.strokeColor = UIColor.blue
                renderer.lineWidth = 3
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
