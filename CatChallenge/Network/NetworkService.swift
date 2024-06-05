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
    private var urlString: String
    private let urlSession: URLSession
    
    init(
        urlString: String = Endpoints.catBreedsURL,
        urlSession: URLSession = .shared
    ) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func fetchCats(page: Int, limit: Int) async throws -> [Cat] {
        guard var url = URL(string: urlString) else { throw CustomError.invalidUrl }
        url = url.appending(queryItems: [URLQueryItem(name: Endpoints.Pagination.nameLimit, value: "\(limit)")])
        url = url.appending(queryItems: [URLQueryItem(name: Endpoints.Pagination.namePage, value: "\(page)")])
        url = url.appending(queryItems: [URLQueryItem(name: Endpoints.APIKey.name, value: Endpoints.APIKey.value)])
        let (data, response) = try await urlSession.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw CustomError.invalidStatusCode }
        guard let catBreeds = try JSONDecoder().decode([Cat]?.self, from: data) else { throw CustomError.failedToDecode }
        return catBreeds
    }
}
