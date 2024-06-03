//
//  NetworkError.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import Foundation

enum NetworkError: Error {
    case generic
    var errorDescription: String? {
        switch self {
        case .generic:
            return "Error"
        }
    }
}
