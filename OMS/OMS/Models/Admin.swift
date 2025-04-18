//
//  Admin.swift
//  OMS
//
//  Created by Deepak Kaligotla on 01/02/23.
//

import Foundation

class Admin {
    var id: Int!
    var name: String!
    var dob: Date!
    var gender: String!
    var govt_id_type: String!
    var govt_id: Int!
    var mobile: String!
    var email: String!
    var password: String?
    var address: String?
    var location_id: Int!
    var role_id: Int!
    var orphanage_id: Int!
    var image: Any!
    var created_at: Int!
    var updated_at: Int!
    
    static func parseAdminList(object: [String: Any]) -> Admin {
            let adminList = Admin()
            adminList.id = object["id"] as? Int
            return adminList
        }
}
