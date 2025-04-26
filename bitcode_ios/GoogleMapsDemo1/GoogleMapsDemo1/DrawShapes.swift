//
//  DrawShapes.swift
//  GoogleMapsDemo1
//
//  Created by Deepak Kaligotla on 25/04/25.
//

import UIKit
import MapKit
import GoogleMaps

struct DrawShapes {
    static func drawCircle(bitcodeCoordinates: CLLocationCoordinate2D, appleMapView: MKMapView, googleMapView: GMSMapView) {
        let appleCircle = MKCircle(center: bitcodeCoordinates, radius: 1000)
        appleMapView.addOverlay(appleCircle)
        let googleCircle = GMSCircle(position: bitcodeCoordinates, radius: 1000)
        googleCircle.fillColor = .lightGray.withAlphaComponent(0.3)
        googleCircle.strokeColor = .brown
        googleCircle.strokeWidth = 2
        googleCircle.map = googleMapView
        googleCircle.zIndex = 10
    }
    
    static func drawPolygon(appleMapView: MKMapView, googleMapView: GMSMapView, centerOfIndia: CLLocationCoordinate2D, northIndia: CLLocationCoordinate2D, westIndia: CLLocationCoordinate2D, southIndia: CLLocationCoordinate2D) {
        let northCenterWestCoordinates = [northIndia, centerOfIndia, westIndia]
        let northCenterWestPolygon = MKPolygon(coordinates: northCenterWestCoordinates, count: northCenterWestCoordinates.count)
        appleMapView.addOverlay(northCenterWestPolygon)
        
        let googleNorthCenterWestPolygon = GMSPolygon()
        let googleNorthCenterWestPath = GMSMutablePath()
        googleNorthCenterWestPath.add(northIndia)
        googleNorthCenterWestPath.add(centerOfIndia)
        googleNorthCenterWestPath.add(westIndia)
        googleNorthCenterWestPolygon.path = googleNorthCenterWestPath
        googleNorthCenterWestPolygon.fillColor = .blue.withAlphaComponent(0.1)
        googleNorthCenterWestPolygon.strokeColor = .blue
        googleNorthCenterWestPolygon.strokeWidth = 2
        googleNorthCenterWestPolygon.map = googleMapView
        
        let westCenterSouthCoordinates = [westIndia, centerOfIndia, southIndia]
        let westCenterSouthPolygon = MKPolygon(coordinates: westCenterSouthCoordinates, count: westCenterSouthCoordinates.count)
        appleMapView.addOverlay(westCenterSouthPolygon)
        
        let googleWestCenterSouthPolygon = GMSPolygon()
        let googleWestCenterSouthPath = GMSMutablePath()
        googleWestCenterSouthPath.add(westIndia)
        googleWestCenterSouthPath.add(centerOfIndia)
        googleWestCenterSouthPath.add(southIndia)
        googleWestCenterSouthPolygon.path = googleWestCenterSouthPath
        googleWestCenterSouthPolygon.fillColor = .green.withAlphaComponent(0.1)
        googleWestCenterSouthPolygon.strokeColor = .green
        googleWestCenterSouthPolygon.strokeWidth = 2
        googleWestCenterSouthPolygon.map = googleMapView
    }
    
    static func drawPolyline(appleMapView: MKMapView, googleMapView: GMSMapView, northIndia: CLLocationCoordinate2D, centerOfIndia: CLLocationCoordinate2D, eastIndia: CLLocationCoordinate2D, southIndia: CLLocationCoordinate2D) {
        let northCenterEastCoordinates = [northIndia, centerOfIndia, eastIndia, northIndia]
        let northCenterEastPolyline = MKPolyline(coordinates: northCenterEastCoordinates, count: northCenterEastCoordinates.count)
        appleMapView.addOverlay(northCenterEastPolyline)
        
        let eastCenterSouthCoordinates = [eastIndia, centerOfIndia, southIndia, eastIndia]
        let eastCenterSouthPolyline = MKPolyline(coordinates: eastCenterSouthCoordinates, count: eastCenterSouthCoordinates.count)
        appleMapView.addOverlay(eastCenterSouthPolyline)
        
        let googleNorthCenterEastPath = GMSMutablePath()
        googleNorthCenterEastPath.add(northIndia)
        googleNorthCenterEastPath.add(centerOfIndia)
        googleNorthCenterEastPath.add(eastIndia)
        googleNorthCenterEastPath.add(northIndia)
        
        let googleNorthCenterEastPolyline = GMSPolyline(path: googleNorthCenterEastPath)
        googleNorthCenterEastPolyline.strokeColor = .red
        googleNorthCenterEastPolyline.strokeWidth = 2
        googleNorthCenterEastPolyline.map = googleMapView
        
        let googleEastCenterSouthPath = GMSMutablePath()
        googleEastCenterSouthPath.add(eastIndia)
        googleEastCenterSouthPath.add(centerOfIndia)
        googleEastCenterSouthPath.add(southIndia)
        googleEastCenterSouthPath.add(eastIndia)
        
        let googleEastCenterSouthPolyline = GMSPolyline(path: googleEastCenterSouthPath)
        googleEastCenterSouthPolyline.strokeColor = .red
        googleEastCenterSouthPolyline.strokeWidth = 2
        googleEastCenterSouthPolyline.map = googleMapView
    }
}
