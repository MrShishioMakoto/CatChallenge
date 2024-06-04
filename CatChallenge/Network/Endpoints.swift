//
//  Endpoints.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import Foundation

struct Endpoints {
    static let catBreedsURL = "https://api.thecatapi.com/v1/breeds"
    struct APIKey {
        static let name = "api_key"
        static let value = "live_m0PGvlXQUPoOzKun79r80ioT8YYh4BicADzSaQKNVCJDZkfeumI9qbO5DoOIUFjC"
    }
    struct Pagination {
        static let nameLimit = "limit"
        static let namePage = "page"
    }
}
