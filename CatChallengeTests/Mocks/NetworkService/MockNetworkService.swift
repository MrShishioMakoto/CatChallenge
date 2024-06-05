//
//  MockNetworkService.swift
//  CatChallengeTests
//
//  Created by goncaloalmeida on 04/06/2024.
//

import Foundation
@testable import CatChallenge

class MockNetworkService: NetworkServiceProtocol, Mockable {
    
    func fetchCats(page: Int, limit: Int) async throws -> [Cat] {
        return loadJSON(filename: "JSONMockCats", type: Cat.self)
    }
}
