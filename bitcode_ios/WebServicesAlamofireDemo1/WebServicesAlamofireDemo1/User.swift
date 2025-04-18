//
//  User.swift
//  WebServicesAlamofireDemo1
//
//  Created by Deepak Kaligotla on 15/04/25.
//

struct User: Decodable {
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
