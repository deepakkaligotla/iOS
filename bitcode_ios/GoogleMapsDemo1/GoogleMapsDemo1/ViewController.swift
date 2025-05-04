//
//  ViewController.swift
//  GoogleMapsDemo1
//
//  Created by Deepak Kaligotla on 22/04/25.
//

import UIKit
import MapKit
import GoogleMaps

class ViewController: UIViewController {
    @IBOutlet private weak var appleMapView: MKMapView!
    @IBOutlet weak var googleMapView: GMSMapView!
    private let bitcodeCoordinates = CLLocationCoordinate2D(latitude: 18.509112, longitude: 73.832558)
    
    private let northIndia = CLLocationCoordinate2D(latitude: 35.800953838244816, longitude: 76.89030211418867)
    private let eastIndia = CLLocationCoordinate2D(latitude: 21.866682343155144, longitude: 89.06285025179386)
    private let centerOfIndia = CLLocationCoordinate2D(latitude: 23.32713256709193, longitude: 77.46362999081612)
    private let westIndia = CLLocationCoordinate2D(latitude: 23.706605336874784, longitude: 68.20669535547495)
    private let southIndia = CLLocationCoordinate2D(latitude: 8.077273172875321, longitude: 77.50429160892963)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appleMapView.delegate = self
        googleMapView.delegate = self
        MapConfigurator.configureAppleMap(appleMapView, coordinate: bitcodeCoordinates)
        MapConfigurator.configureGoogleMap(googleMapView, coordinate: bitcodeCoordinates)
        ZoomControl.setup(for: appleMapView, zoomIn: #selector(appleZoomIn), zoomOut: #selector(appleZoomOut), target: self)
        ZoomControl.setup(for: googleMapView, zoomIn: #selector(googleZoomIn), zoomOut: #selector(googleZoomOut), target: self, in: googleMapView)
        DrawShapes.drawCircle(bitcodeCoordinates: bitcodeCoordinates, appleMapView: appleMapView, googleMapView: googleMapView)
        DrawShapes.drawPolygon(appleMapView: appleMapView, googleMapView: googleMapView, centerOfIndia: centerOfIndia, northIndia: northIndia, westIndia: westIndia, southIndia: southIndia)
        DrawShapes.drawPolyline(appleMapView: appleMapView, googleMapView: googleMapView, northIndia: northIndia, centerOfIndia: centerOfIndia, eastIndia: eastIndia, southIndia: southIndia)
    }
    
    @objc private func appleZoomIn() {
        ZoomControl.zoomAppleMap(appleMapView, zoomIn: true)
    }
    
    @objc private func appleZoomOut() {
        ZoomControl.zoomAppleMap(appleMapView, zoomIn: false)
    }
    
    @objc private func googleZoomIn() {
        ZoomControl.zoomGoogleMap(googleMapView, zoomIn: true)
    }
    
    @objc private func googleZoomOut() {
        ZoomControl.zoomGoogleMap(googleMapView, zoomIn: false)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: circleOverlay)
            renderer.fillColor = .lightGray.withAlphaComponent(0.3)
            renderer.strokeColor = .brown
            renderer.lineWidth = 2
            return renderer
        } else if let polygonOverlay = overlay as? MKPolygon {
            let renderer = MKPolygonRenderer(polygon: polygonOverlay)
            renderer.fillColor = .blue.withAlphaComponent(0.1)
            renderer.strokeColor = .blue
            renderer.lineWidth = 2
            return renderer
        } else if let polylineOverlay = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polylineOverlay)
            renderer.strokeColor = .red
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer()
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("didTapAt method -- Latitude \(coordinate.latitude) -- Longitude \(coordinate.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        print("didTapAtMyLocation method -- Latitude \(location.latitude) -- Longitude \(location.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf method -- Latitude \(marker.position.latitude) -- Longitude \(marker.position.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let cgRectForInfoWindow = CGRect(x: 0, y: 0, width: 200, height: 100)

        let infoWindiwView = UIView(frame: cgRectForInfoWindow)
        infoWindiwView.backgroundColor = .cyan
        
        let cgRectForLabelOne = CGRect(x: 20, y: 20, width: 160, height: 30)
        
        let labelOne = UILabel(frame: cgRectForLabelOne)
        labelOne.text = "\(marker.title!)"
        
        labelOne.backgroundColor = .lightGray
        labelOne.textAlignment = .center
        
        infoWindiwView.addSubview(labelOne)
        
        let cgRectForLabelTwo = CGRect(x: 20, y: 65, width: 160, height: 30)
        
        let labelTwo = UILabel(frame: cgRectForLabelTwo)
        labelTwo.backgroundColor = .lightGray
        labelTwo.text = "\(marker.snippet!)"
        
        infoWindiwView.addSubview(labelTwo)
        
        return infoWindiwView
    }
    

    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        print("did close info window")
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("didDrag method -- Latitude \(marker.position.latitude) -- Longitude \(marker.position.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("didBeginDragging method -- Latitude \(marker.position.latitude) -- Longitude \(marker.position.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("didEndDragging method -- Latitude \(marker.position.latitude) -- Longitude \(marker.position.longitude)")
    }
}
