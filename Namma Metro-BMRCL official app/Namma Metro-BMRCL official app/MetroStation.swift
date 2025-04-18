//
//  Item.swift
//  Namma Metro-BMRCL official app
//
//  Created by Deepak Kaligotla on 06/08/24.
//

import Foundation
import SwiftData
import CoreLocation

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double

    var CLLocationCoordinate2D: CLLocationCoordinate2D {
        return CoreLocation.CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

@Model
final class MetroStation: Codable, Identifiable {
    let id = UUID()
    let name: String
    let details: String
    let coordinates: [Coordinate]

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case details
        case geometry
    }

    enum GeometryKeys: String, CodingKey {
        case coordinates
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        details = try container.decode(String.self, forKey: .details)

        let geometryContainer = try container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
        let coordinatesArray = try geometryContainer.decode([[Double]].self, forKey: .coordinates)

        coordinates = coordinatesArray.map { Coordinate(latitude: $0[1], longitude: $0[0]) }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(details, forKey: .details)
        
        var geometryContainer = container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
        
        let coordinatesArray = coordinates.map { [$0.longitude, $0.latitude] }
        try geometryContainer.encode(coordinatesArray, forKey: .coordinates)
    }
}

struct MetroStations: Codable {
    let features: [MetroStation]

    enum CodingKeys: String, CodingKey {
        case features
    }
}
