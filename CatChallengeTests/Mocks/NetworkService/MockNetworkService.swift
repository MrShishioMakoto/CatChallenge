//
//  MockNetworkService.swift
//  CatChallengeTests
//
//  Created by goncaloalmeida on 04/06/2024.
//

import Foundation
@testable import CatChallenge

class MockNetworkService: NetworkServiceProtocol {
    var fetchCatsResult: Result<[Cat], CustomError>?
    
    func fetchCats(page: Int, limit: Int) async throws -> [Cat] {
        if let result = fetchCatsResult {
            switch result {
            case .success(let cats):
                return cats
            case .failure(let error):
                throw error
            }
        }
        return []
    }
}
