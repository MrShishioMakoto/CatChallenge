//
//  NetworkService.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchCats() async throws -> [Cat]
}

class NetworkService: NetworkServiceProtocol {
    private let urlSession: URLSession
    private let endpoint: String
    
    init(
        endpoint: String,
        urlSession: URLSession = URLSession.shared
    ) {
        self.endpoint = endpoint
        self.urlSession = urlSession
    }
    
    func fetchCats() async throws -> [Cat] {
        guard
            var url = URL(string: endpoint)
        else {
            //TODO
            throw NetworkError.generic
        }
        url = url.appending(queryItems: [URLQueryItem(name: Endpoints.APIKey.name, value: Endpoints.APIKey.value)])
        let (data, response) = try await URLSession.shared.data(from: url)
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 && httpResponse.statusCode <= 300
        else {
            //TODO
            throw NetworkError.generic
        }
        guard
            let catBreeds = try JSONDecoder().decode([Cat]?.self, from: data)
        else {
            //TODO
            throw NetworkError.generic
        }
        return catBreeds
    }
}
