//
//  CatsViewModelTests.swift
//  CatChallengeTests
//
//  Created by goncaloalmeida on 05/06/2024.
//

import XCTest
@testable import CatChallenge

@MainActor
final class CatsViewModelTests: XCTestCase {

    var catsViewModel: CatsViewModel!
    
    override func setUp() {
        super.setUp()
        catsViewModel = CatsViewModel(service: MockNetworkService())
    }

    override func tearDown() {
        super.tearDown()
        catsViewModel = nil
    }
    
//    func test_fetchCats_success() async throws {
//        //Arrange
//        let expectation = XCTestExpectation(description: "Fetch Some Cats")
//        var cats: [Cat] = []
//        
//        //Act
//        do {
//            cats = try await catsViewModel.fetchSomeCats()
//            expectation.fulfill()
//        } catch {
//            
//        }
//        
//        //Assert
//        XCTAssertEqual(catsViewModel.catList.count, 10)
//        wait(for: [expectation], timeout: 5)
//    }
}
