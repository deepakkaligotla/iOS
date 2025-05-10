//
//  ApiService.swift
//  Assignment07
//
//  Created by Deepak Kaligotla on 11/05/25.
//

protocol ApiService {
    func getAllTodos() async throws -> [Todo]
    func getAllComments() async throws -> [Comment]
    func getAllAlbums() async throws -> [Album]
    func getAllPhotos() async throws -> [Photo]
}
