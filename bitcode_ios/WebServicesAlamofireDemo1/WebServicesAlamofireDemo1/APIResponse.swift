//
//  APIResponse.swift
//  WebServicesAlamofireDemo1
//
//  Created by Deepak Kaligotla on 15/04/25.
//

struct APIResponse: Decodable {
    var page: Int
    var perPage: Int
    var total: Int
    var totalPages: Int
    var data: [User]
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
        self.data = try container.decode([User].self, forKey: .data)
        self.support = try container.decode(Support.self, forKey: .support)
    }
}
