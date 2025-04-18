//
//  Item.swift
//  SwiftCharts
//
//  Created by Deepak Kaligotla on 15/05/24.
//

import Foundation
import SwiftData

let chartsData: [any PersistentModel.Type] = [Place.self, Address.self]

enum PlaceType: String, CaseIterable {
    case accounting
    case airport
    case amusement_park
    case aquarium
    case art_gallery
    case atm
    case bakery
    case bank
    case bar
    case beauty_salon
    case bicycle_store
    case book_store
    case bowling_alley
    case bus_station
    case cafe
    case campground
    case car_dealer
    case car_rental
    case car_repair
    case car_wash
    case casino
    case cemetery
    case church
    case city_hall
    case clothing_store
    case convenience_store
    case courthouse
    case dentist
    case department_store
    case doctor
    case drugstore
    case electrician
    case electronics_store
    case embassy
    case fire_station
    case florist
    case funeral_home
    case furniture_store
    case gas_station
    case gym
    case hair_care
    case hardware_store
    case hindu_temple
    case home_goods_store
    case hospital
    case insurance_agency
    case jewelry_store
    case laundry
    case lawyer
    case library
    case light_rail_station
    case liquor_store
    case local_government_office
    case locksmith
    case lodging
    case meal_delivery
    case meal_takeaway
    case mosque
    case movie_rental
    case movie_theater
    case moving_company
    case museum
    case night_club
    case painter
    case park
    case parking
    case pet_store
    case pharmacy
    case physiotherapist
    case plumber
    case police
    case post_office
    case primary_school
    case real_estate_agency
    case restaurant
    case roofing_contractor
    case rv_park
    case school
    case secondary_school
    case shoe_store
    case shopping_mall
    case spa
    case stadium
    case storage
    case store
    case subway_station
    case supermarket
    case synagogue
    case taxi_stand
    case tourist_attraction
    case train_station
    case transit_station
    case travel_agency
    case university
    case veterinary_care
    case zoo
}

enum AddressType: String, CaseIterable {
    case administrative_area
    case archipelago
    case colloquial_area
    case continent
    case country
    case establishment
    case finance
    case floor
    case food
    case general_contractor
    case geocode
    case health
    case intersection
    case landmark
    case locality
    case natural_feature
    case neighborhood
    case place_of_worship
    case plus_code
    case point_of_interest
    case political
    case post_box
    case postal_code
    case postal_town
    case premise
    case room
    case route
    case street_address
    case street_number
    case sublocality
    case subpremise
    case town_square
}

@Model
final class Address: Identifiable, Codable {
    @Attribute(.unique)
    var address_id: UUID
    var area: String
    var taluk: String
    var division: String
    var district: String
    var state: String
    var pincode: Int
    
    enum CodingKeys: CodingKey {
        case address_id, area, taluk, division, district, state, pincode
    }
    
    @Relationship(deleteRule: .cascade, inverse: \Place.place_address)
    var places: [Place] = []
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        address_id = UUID()
        area = try container.decode(String.self, forKey: .area)
        taluk = try container.decode(String.self, forKey: .taluk)
        division = try container.decode(String.self, forKey: .division)
        district = try container.decode(String.self, forKey: .district)
        state = try container.decode(String.self, forKey: .state)
        pincode = try container.decode(Int.self, forKey: .pincode)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(address_id, forKey: .address_id)
        try container.encode(area, forKey: .area)
        try container.encode(taluk, forKey: .taluk)
        try container.encode(division, forKey: .division)
        try container.encode(district, forKey: .district)
        try container.encode(state, forKey: .state)
        try container.encode(pincode, forKey: .pincode)
    }
}

@Model
final class Place {
    @Attribute(.unique)
    var place_id: UUID
    var place_name: String
    @Relationship var place_address: Address
    var place_type: String
    var address_type: String
    var rating: Double
    
    init(new_place_id: UUID = UUID(), new_place_name: String, new_place_address: Address, new_place_type: String, new_address_type: String, new_rating: Double) {
        self.place_id = new_place_id
        self.place_name = new_place_name
        self.place_address = new_place_address
        self.place_type = new_place_type
        self.address_type = new_address_type
        self.rating = new_rating
    }
}
