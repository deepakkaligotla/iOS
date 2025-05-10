//
//  NetworkService.swift
//  Assignment07
//
//  Created by Deepak Kaligotla on 11/05/25.
//

import Alamofire

open class NetworkService {
    public static let shared: NetworkService = {
        return NetworkService()
    }()
    private init() {}
    
    func request<T: Decodable>(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil
    ) async -> DataResponse<T, AFError> {
        return await AF.request(
            url,
            method: method,
            parameters: parameters,
            headers: headers)
        .validate()
        .serializingDecodable(T.self)
        .response
    }
}

extension NetworkService: ApiService {
    private func fullURL(endpoint: String) -> String {
        "https://jsonplaceholder.typicode.com/\(endpoint)"
    }
    
    func getAllTodos() async throws -> [Todo] {
        let response: DataResponse<[Todo], AFError> = await request(fullURL(endpoint: "todos"))
        switch response.result {
        case .success(let todos):
            return todos
        case .failure(let error):
            throw error
        }
    }
    
    func getAllComments() async throws -> [Comment] {
        let response: DataResponse<[Comment], AFError> = await request(fullURL(endpoint: "comments"))
        switch response.result {
        case .success(let comments):
            return comments
        case .failure(let error):
            throw error
        }
    }
    
    func getAllAlbums() async throws -> [Album] {
        let response: DataResponse<[Album], AFError> = await request(fullURL(endpoint: "albums"))
        switch response.result {
        case .success(let albums):
            return albums
        case .failure(let error):
            throw error
        }
    }
    
    func getAllPhotos() async throws -> [Photo] {
        let response: DataResponse<[Photo], AFError> = await request(fullURL(endpoint: "photos"))
        switch response.result {
        case .success(let photos):
            return photos
        case .failure(let error):
            throw error
        }
    }
}
