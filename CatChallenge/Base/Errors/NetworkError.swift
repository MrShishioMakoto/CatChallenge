//
//  NetworkError.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import Foundation

enum NetworkError: Error {
    case generic
    case invalidUrl
    case failedToDecode
    case invalidStatusCode
    case custom(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .generic:
            return LocalizableKeys.NetworkError.generic
        case .invalidUrl:
            return LocalizableKeys.NetworkError.url
        case .failedToDecode:
            return LocalizableKeys.NetworkError.decode
        case .invalidStatusCode:
            return LocalizableKeys.NetworkError.invalid
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
