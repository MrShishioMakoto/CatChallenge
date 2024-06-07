//
//  CatsViewModelTests.swift
//  CatChallengeTests
//
//  Created by goncaloalmeida on 05/06/2024.
//

import XCTest
import Foundation
@testable import CatChallenge

@MainActor
final class CatsViewModelTests: XCTestCase {
    
    var viewModel: CatsViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = CatsViewModel(service: mockNetworkService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func test_fetchSomeCats_success() async {
        // Arrange
        let catsMock = [Cat.Mock.makeMock(), Cat.Mock.makeMock(), Cat.Mock.makeMock()]
        mockNetworkService.fetchCatsResult = .success(catsMock)
        
        // Act
        viewModel.fetchSomeCats()
        
        // Assert
        XCTAssertEqual(viewModel.catList, catsMock)
        XCTAssertFalse(viewModel.hasError)
        XCTAssertNil(viewModel.error)
    }
    
    func test_fetchSomeCats_failure() async {
        // Arrange
        mockNetworkService.fetchCatsResult = .failure(.failedToDecode)
        
        // Act
        viewModel.fetchSomeCats()
        
        // Assert
        XCTAssertTrue(viewModel.catList.isEmpty)
        XCTAssertTrue(viewModel.hasError)
        XCTAssertEqual(viewModel.error, .failedToDecode)
    }
    
    func test_filterCats() {
        // Arrange
        let cat1 = Cat.Mock.makeMock(
            id: "1",
            name: "Bengal",
            origin: "Asia",
            temperament: "Agile",
            description:
                "Wild look",
            lifeSpan: "12-15 years",
            image: nil
        )
        let cat2 = Cat.Mock.makeMock(
            id: "2",
            name: "Siamese",
            origin: "Asia",
            temperament: "Friendly",
            description: "Elegant",
            lifeSpan: "10-12 years",
            image: nil
        )
        
        // Act
        viewModel.catList = [cat1, cat2]
        viewModel.searchText = "Bengal"
        
        // Assert
        XCTAssertEqual(viewModel.filteredCats, [cat1])
    }
}
