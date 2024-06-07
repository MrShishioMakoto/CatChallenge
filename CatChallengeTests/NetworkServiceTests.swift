//
//  NetworkServiceTests.swift
//  CatChallengeTests
//
//  Created by goncaloalmeida on 04/06/2024.
//

import XCTest
import Foundation
@testable import CatChallenge

final class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    var urlSessionMock: MockUrlProtocol!
    
    func test_networkService_success() async throws {
        //Arrange
        makeSUT()
        networkService = NetworkService(urlString: Endpoints.catBreedsURL)
        var cats: [Cat] = []
        
        //Act
        do {
            cats = try await networkService.fetchCats(page: 0, limit: 20)
        } catch {
            print("Not supposed to happen")
        }
        
        //Assert
        XCTAssertNotNil(cats)
    }
    
    func test_networkService_invalidURL_error() async throws {
        //Arrange
        makeSUT()
        networkService = NetworkService(urlString: "invalid_url")
        
        //Act
        do {
            _ = try await networkService.fetchCats(page: 0, limit: 20)
        } catch let error as CustomError {
            // Assert
            XCTAssertEqual(error, .invalidUrl)
        }
    }
    
    func test_networkService_invalidStatusCode_error() async throws {
        //Arrange
        makeSUT()
        MockUrlProtocol.testData = Data()
        MockUrlProtocol.response = HTTPURLResponse(url: URL(string: Endpoints.catBreedsURL)!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        //Act
        do {
            _ = try await networkService.fetchCats(page: 0, limit: 20)
        } catch let error as CustomError {
            // Assert
            XCTAssertEqual(error, .invalidStatusCode)
        }
    }
    
    func test_networkService_failedToDecode_error() async {
        //Arrange
        makeSUT()
        MockUrlProtocol.testData = InvalidJson.data(using: .utf8)!
        MockUrlProtocol.response = HTTPURLResponse(url: URL(string: Endpoints.catBreedsURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //Act
        do {
            _ = try await networkService.fetchCats(page: 0, limit: 20)
        } catch let error {
            //Assert
            XCTAssertEqual(error as? CustomError, CustomError.failedToDecode)
        }
    }
    
    func makeSUT() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockUrlProtocol.self]
        let session = URLSession(configuration: config)
        
        networkService = NetworkService(urlSession: session)
    }
}
