//
//  Comment.swift
//  Test3
//
//  Created by Deepak Kaligotla on 05/05/25.
//

struct Comment: Decodable {
    var id: Int
    var body: String
    var postId: Int
    var likes: Int
    var user: User
}
