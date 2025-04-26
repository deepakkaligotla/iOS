//
//  ZoomControl.swift
//  GoogleMapsDemo1
//
//  Created by Deepak Kaligotla on 24/04/25.
//

import UIKit
import MapKit
import GoogleMaps

struct ZoomControl {

    static func setup(for mapView: UIView, zoomIn: Selector, zoomOut: Selector, target: Any, in container: UIView? = nil) {
        let zoomInButton = createZoomButton(title: "+", action: zoomIn, target: target)
        let zoomOutButton = createZoomButton(title: "-", action: zoomOut, target: target)

        mapView.addSubview(zoomInButton)
        mapView.addSubview(zoomOutButton)

        zoomInButton.translatesAutoresizingMaskIntoConstraints = false
        zoomOutButton.translatesAutoresizingMaskIntoConstraints = false

        let anchorView = container ?? mapView

        NSLayoutConstraint.activate([
            zoomOutButton.trailingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: -20),
            zoomOutButton.bottomAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: -10),
            zoomOutButton.widthAnchor.constraint(equalToConstant: 44),
            zoomOutButton.heightAnchor.constraint(equalToConstant: 44),

            zoomInButton.trailingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: -20),
            zoomInButton.bottomAnchor.constraint(equalTo: zoomOutButton.topAnchor, constant: -10),
            zoomInButton.widthAnchor.constraint(equalToConstant: 44),
            zoomInButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }

    private static func createZoomButton(title: String, action: Selector, target: Any) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        button.layer.cornerRadius = 6
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }

    static func zoomAppleMap(_ mapView: MKMapView, zoomIn: Bool) {
        var region = mapView.region
        region.span.latitudeDelta *= zoomIn ? 0.5 : 2
        region.span.longitudeDelta *= zoomIn ? 0.5 : 2
        mapView.setRegion(region, animated: true)
    }

    static func zoomGoogleMap(_ mapView: GMSMapView, zoomIn: Bool) {
        let newZoom = mapView.camera.zoom + (zoomIn ? 1 : -1)
        mapView.animate(toZoom: newZoom)
    }
}
