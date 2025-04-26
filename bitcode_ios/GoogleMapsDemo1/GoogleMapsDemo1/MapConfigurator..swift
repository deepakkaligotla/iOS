//
//  MapConfigurator..swift
//  GoogleMapsDemo1
//
//  Created by Deepak Kaligotla on 24/04/25.
//

import MapKit
import GoogleMaps

struct MapConfigurator {
    static func configureAppleMap(_ mapView: MKMapView, coordinate: CLLocationCoordinate2D) {
        let annotation = CustomAnnotation(coordinate: coordinate)
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.setRegion(region, animated: true)
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isPitchEnabled = true
        mapView.isMultipleTouchEnabled = true
    }

    static func configureGoogleMap(_ mapView: GMSMapView, coordinate: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 14.6)
        mapView.camera = camera
        let marker = GMSMarker(position: coordinate)
        marker.title = "Bitcode Technologies, Erandwane"
        marker.snippet = "Pune, Maharashtra, India"
        marker.map = mapView
        marker.isDraggable = true
        mapView.mapType = .normal
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = true
        mapView.settings.tiltGestures = true
        mapView.isTrafficEnabled = true
        mapView.isBuildingsEnabled = true
        mapView.isIndoorEnabled = true
    }
}
