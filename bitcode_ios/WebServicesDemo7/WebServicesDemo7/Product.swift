//
//  Product.swift
//  WebServicesDemo7
//
//  Created by Deepak Kaligotla on 14/04/25.
//

struct Product: Decodable {
    var id: Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var productImage: String
    var rating: Rating
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description
        case category
        case productImage = "image"
        case rating
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.price = try container.decode(Double.self, forKey: .price)
        self.description = try container.decode(String.self, forKey: .description)
        self.category = try container.decode(String.self, forKey: .category)
        self.productImage = try container.decode(String.self, forKey: .productImage)
        self.rating = try container.decode(Rating.self, forKey: .rating)
    }
}
