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
    
    private var networkService: NetworkService!
    private let apiURL = URL(string: Endpoints.catBreedsURL)!
    
    override func setUp() {
        super.setUp()
        
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        
        networkService = NetworkService(urlSession: urlSession)
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    func test_networkService_success() async throws {
        //Arrange
        let expectation = XCTestExpectation(description: "Fetch Some Cats")
        let data = JSONMockCats.data(using: .utf8)
        mockRequestHandler(with: data)
        var cats: [Cat] = []
        
        //Act
        do {
            do {
                cats = try await networkService.fetchCats(page: 0, limit: 10)
                expectation.fulfill()
            } catch {
                print("Not supposed to happen")
            }
        }
        
        //Assert
        XCTAssertNotNil(cats)
        XCTAssertEqual(cats.count, 10)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_networkService_invalidURL_error() async throws {
        //Arrange
        let expectation = XCTestExpectation(description: "Error: Invalid URL")
        let data = JSONMockCats.data(using: .utf8)
        mockRequestHandler(with: data)
        let urlString: String = ""
        let networkService = NetworkService(urlString: urlString)
        var err: Error = CustomError.generic
        
        //Act
        do {
            _ = try await networkService.fetchCats(page: 0, limit: 10)
        } catch let error {
            err = error
            expectation.fulfill()
        }
        
        //Assert
        XCTAssertEqual(err as? CustomError, CustomError.invalidUrl)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_networkService_invalidStatusCode_error() async throws {
        //Arrange
        let expectation = XCTestExpectation(description: "Error: Invalid Status Code")
        let data = JSONMockCats.data(using: .utf8)
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 40, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        var err: Error = CustomError.generic
        
        //Act
        do {
            _ = try await networkService.fetchCats(page: 0, limit: 10)
        } catch let error {
            err = error
            expectation.fulfill()
        }
        
        //Assert
        XCTAssertEqual(err as? CustomError, CustomError.invalidStatusCode)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
//    func test_networkService_failedToDecode_error() async throws {
//        let expectation = XCTestExpectation(description: "Error: Failed to decode")
//        let data = JSONMockCatsDecodeError.data(using: .utf8)
//        mockRequestHandler(with: data)
//        var err: Error = CustomError.generic
//
//        //Act
//        do {
//            _ = try await networkService.fetchCats(page: 0, limit: 10)
//        } catch let error {
//            err = error
//            expectation.fulfill()
//        }
//
//        //Assert
//        XCTAssertEqual(err as? CustomError, CustomError.typeMismatch)
//
//        wait(for: [expectation], timeout: 5.0)
//    }
}

extension NetworkServiceTests {
    private func mockRequestHandler(with data: Data?) {
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                throw NSError(domain: "", code: -1)
            }
            
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, data)
        }
    }
    
}
