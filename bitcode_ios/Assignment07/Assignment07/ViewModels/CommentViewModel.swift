//
//  CommentViewModel.swift
//  Assignment07
//
//  Created by Deepak Kaligotla on 11/05/25.
//

class CommentViewModel {
    var comments: [Comment] = []

    func fetchComments() async {
        do {
            self.comments = try await NetworkService.shared.getAllComments()
        } catch {
            print("Failed to fetch comments: \(error.localizedDescription)")
        }
    }
}
