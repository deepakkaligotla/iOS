//
//  CustomAnnotation.swift
//  GoogleMapsDemo1
//
//  Created by Deepak Kaligotla on 22/04/25.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
