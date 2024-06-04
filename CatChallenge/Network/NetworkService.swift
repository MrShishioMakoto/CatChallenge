//
//  NetworkService.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchCats(page: Int, limit: Int) async throws -> [Cat]
}

class NetworkService: NetworkServiceProtocol {
    private let urlSession: URLSession
    
    init(
        urlSession: URLSession = URLSession.shared
    ) {
        self.urlSession = urlSession
    }
    
    func fetchCats(page: Int, limit: Int) async throws -> [Cat] {
        guard var url = URL(string: Endpoints.catBreedsURL) else { throw NetworkError.invalidUrl }
        url = url.appending(queryItems: [URLQueryItem(name: Endpoints.Pagination.nameLimit, value: "\(limit)")])
        url = url.appending(queryItems: [URLQueryItem(name: Endpoints.Pagination.namePage, value: "\(page)")])
        url = url.appending(queryItems: [URLQueryItem(name: Endpoints.APIKey.name, value: Endpoints.APIKey.value)])
        let (data, response) = try await urlSession.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.invalidStatusCode }
        guard let catBreeds = try JSONDecoder().decode([Cat]?.self, from: data) else { throw NetworkError.failedToDecode }
        return catBreeds
    }
}
