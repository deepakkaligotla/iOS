//
//  APIResponse.swift
//  Asssignment05
//
//  Created by Deepak Kaligotla on 23/04/25.
//

struct APIResponse {
    var products: [Product]
    var total: Int
    var skip: Int
    var limit: Int

    func toDictionary() -> [String: Any] {
        return [
            "products": products.map { $0.toDictionary() },
            "total": total,
            "skip": skip,
            "limit": limit
        ]
    }

    static func fromDictionary(_ dict: [String: Any]) -> APIResponse {
        return APIResponse(
            products: (dict["products"] as! [[String: Any]]).map { Product.fromDictionary($0) },
            total: dict["total"] as! Int,
            skip: dict["skip"] as! Int,
            limit: dict["limit"] as! Int
        )
    }
}

struct Product {
    var id: Int
    var title: String
    var description: String
    var category: String
    var price: Double
    var discountPercentage: Double
    var rating: Double
    var stock: Int
    var tags: [String]
    var brand: String?
    var sku: String
    var weight: Int
    var dimensions: Dimensions
    var warrantyInformation: String
    var shippingInformation: String
    var availabilityStatus: String
    var reviews: [Review]
    var returnPolicy: String
    var minimumOrderQuantity: Int
    var meta: Meta
    var images: [String]
    var thumbnail: String

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "title": title,
            "description": description,
            "category": category,
            "price": price,
            "discountPercentage": discountPercentage,
            "rating": rating,
            "stock": stock,
            "tags": tags,
            "brand": brand,
            "sku": sku,
            "weight": weight,
            "dimensions": dimensions.toDictionary(),
            "warrantyInformation": warrantyInformation,
            "shippingInformation": shippingInformation,
            "availabilityStatus": availabilityStatus,
            "reviews": reviews.map { $0.toDictionary() },
            "returnPolicy": returnPolicy,
            "minimumOrderQuantity": minimumOrderQuantity,
            "meta": meta.toDictionary(),
            "images": images,
            "thumbnail": thumbnail
        ]
    }

    static func fromDictionary(_ dict: [String: Any]) -> Product {
        return Product(
            id: dict["id"] as! Int,
            title: dict["title"] as! String,
            description: dict["description"] as! String,
            category: dict["category"] as! String,
            price: dict["price"] as! Double,
            discountPercentage: dict["discountPercentage"] as! Double,
            rating: dict["rating"] as! Double,
            stock: dict["stock"] as! Int,
            tags: dict["tags"] as! [String],
            brand: dict["brand"] as? String,
            sku: dict["sku"] as! String,
            weight: dict["weight"] as! Int,
            dimensions: Dimensions.fromDictionary(dict["dimensions"] as! [String: Any]),
            warrantyInformation: dict["warrantyInformation"] as! String,
            shippingInformation: dict["shippingInformation"] as! String,
            availabilityStatus: dict["availabilityStatus"] as! String,
            reviews: (dict["reviews"] as! [[String: Any]]).map { Review.fromDictionary($0) },
            returnPolicy: dict["returnPolicy"] as! String,
            minimumOrderQuantity: dict["minimumOrderQuantity"] as! Int,
            meta: Meta.fromDictionary(dict["meta"] as! [String: Any]),
            images: dict["images"] as! [String],
            thumbnail: dict["thumbnail"] as! String
        )
    }
}

struct Dimensions {
    var width: Double
    var height: Double
    var depth: Double

    func toDictionary() -> [String: Any] {
        return [
            "width": width,
            "height": height,
            "depth": depth
        ]
    }

    static func fromDictionary(_ dict: [String: Any]) -> Dimensions {
        return Dimensions(
            width: dict["width"] as! Double,
            height: dict["height"] as! Double,
            depth: dict["depth"] as! Double
        )
    }
}

struct Review {
    var rating: Double
    var comment: String
    var date: String
    var reviewerName: String
    var reviewerEmail: String

    func toDictionary() -> [String: Any] {
        return [
            "rating": rating,
            "comment": comment,
            "date": date,
            "reviewerName": reviewerName,
            "reviewerEmail": reviewerEmail
        ]
    }

    static func fromDictionary(_ dict: [String: Any]) -> Review {
        return Review(
            rating: dict["rating"] as! Double,
            comment: dict["comment"] as! String,
            date: dict["date"] as! String,
            reviewerName: dict["reviewerName"] as! String,
            reviewerEmail: dict["reviewerEmail"] as! String
        )
    }
}

struct Meta {
    var createdAt: String
    var updatedAt: String
    var barcode: String
    var qrCode: String

    func toDictionary() -> [String: Any] {
        return [
            "createdAt": createdAt,
            "updatedAt": updatedAt,
            "barcode": barcode,
            "qrCode": qrCode
        ]
    }

    static func fromDictionary(_ dict: [String: Any]) -> Meta {
        return Meta(
            createdAt: dict["createdAt"] as! String,
            updatedAt: dict["updatedAt"] as! String,
            barcode: dict["barcode"] as! String,
            qrCode: dict["qrCode"] as! String
        )
    }
}
