//
//  PostsApiResponse.swift
//  Asssignment05
//
//  Created by Deepak Kaligotla on 23/04/25.
//

struct PostsApiResponse {
    var posts: [Post]
    var total: Int
    var skip: Int
    var limit: Int
    
    func toDictionary() -> [String: Any] {
        return [
            "posts": posts.map { $0.toDictionary() },
            "total": total,
            "skip": skip,
            "limit": limit
        ]
    }

    static func fromDictionary(_ dict: [String: Any]) -> PostsApiResponse {
        return PostsApiResponse(
            posts: (dict["posts"] as! [[String: Any]]).map { Post.fromDictionary($0) },
            total: dict["total"] as! Int,
            skip: dict["skip"] as! Int,
            limit: dict["limit"] as! Int
        )
    }
}

struct Post {
    var id: Int
    var title: String
    var body: String
    var tags: [String]
    var reactions: Reaction
    var views: Int
    var userId: Int
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "title": title,
            "body": body,
            "tags": tags,
            "reactions": reactions.toDictionary(),
            "views": views,
            "userId": userId
        ]
    }
    
    static func fromDictionary(_ dict: [String: Any]) -> Post {
        return Post(
            id: dict["id"] as! Int,
            title: dict["title"] as! String,
            body: dict["body"] as! String,
            tags: (dict["tags"] as! [String]).map(\.self),
            reactions: Reaction.fromDictionary(dict["reactions"] as! [String: Any]),
            views: dict["views"] as! Int,
            userId: dict["userId"] as! Int
        )
    }
}

struct Reaction {
    var likes: Int
    var dislikes: Int
    
    func toDictionary() -> [String: Any] {
        return [
            "likes": likes,
            "dislikes": dislikes
        ]
    }
    
    static func fromDictionary(_ dict: [String: Any]) -> Reaction {
        return Reaction(
            likes: dict["likes"] as! Int,
            dislikes: dict["dislikes"] as! Int
        )
    }
}
