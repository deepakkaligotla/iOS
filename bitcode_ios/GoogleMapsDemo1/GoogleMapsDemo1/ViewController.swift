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
    private var allAnnotations: [MKAnnotation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let puneCoordinate = CLLocationCoordinate2D(latitude: 18.5204, longitude: 73.8567)
        
        //Apple Maps
        let puneAnnotation = CustomAnnotation(coordinate: puneCoordinate)
        allAnnotations = [puneAnnotation]
        appleMapView.addAnnotations(allAnnotations!)
        let region = MKCoordinateRegion(center: puneCoordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        appleMapView.setRegion(region, animated: true)
        appleMapView.isZoomEnabled = true
        
        //Google Maps
        let camera = GMSCameraPosition.camera(withTarget: puneCoordinate, zoom: 12)
        googleMapView.camera = camera
        let marker = GMSMarker(position: puneCoordinate)
        marker.title = "Pune"
        marker.snippet = "Maharashtra, India"
        marker.map = googleMapView
        googleMapView.settings.zoomGestures = true
    }
}
