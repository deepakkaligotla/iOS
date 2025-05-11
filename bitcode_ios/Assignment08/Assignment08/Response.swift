//
//  User.swift
//  Assignment08
//
//  Created by Deepak Kaligotla on 11/05/25.
//

struct JsonplaceholderUser: Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
}

struct Address: Codable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo
}

struct Geo: Codable {
    var lat: String
    var lng: String
}

struct Company: Codable {
    var name: String
    var catchPhrase: String
    var bs: String
}

struct APIResponse: Codable {
    var page: Int
    var perPage: Int
    var total: Int
    var totalPages: Int
    var data: [ResReqUser]
    var support: Support

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
        case support
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.perPage = try container.decode(Int.self, forKey: .perPage)
        self.total = try container.decode(Int.self, forKey: .total)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.data = try container.decode([ResReqUser].self, forKey: .data)
        self.support = try container.decode(Support.self, forKey: .support)
    }
}

struct Support: Codable {
    var url: String
    var text: String
}

struct ResReqUser: Codable {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.avatar = try container.decode(String.self, forKey: .avatar)
    }
}
