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
    
    var mockNetworkService: MockNetworkService = MockNetworkService()
    var viewModel: CatsViewModel!
    
    func test_fetchSomeCats_success() async {
        // Arrange
        let catsMock = [Cat.Mock.makeMock(), Cat.Mock.makeMock(), Cat.Mock.makeMock()]
        viewModel = CatsViewModel(service: mockNetworkService)
        mockNetworkService.fetchCatsResult = .success(catsMock)
        
        // Act
        try! await viewModel.fetchSomeCats()
        
        // Assert
        XCTAssertEqual(viewModel.catList, catsMock)
        XCTAssertFalse(viewModel.hasError)
        XCTAssertNil(viewModel.error)
    }
    
    func test_fetchSomeCats_appendItems_success() async {
        // Arrange
        let firstPageCats = [Cat.Mock.makeMock(id: "1", name: "Cat 1"), Cat.Mock.makeMock(id: "2", name: "Cat 2")]
        let secondPageCats = [Cat.Mock.makeMock(id: "3", name: "Cat 3"), Cat.Mock.makeMock(id: "4", name: "Cat 4")]
        viewModel = CatsViewModel(service: mockNetworkService)

        // Act
        mockNetworkService.fetchCatsResult = .success(firstPageCats)
        try! await viewModel.fetchSomeCats()
        XCTAssertEqual(viewModel.catList.count, firstPageCats.count)

        mockNetworkService.fetchCatsResult = .success(secondPageCats)
        try! await viewModel.fetchSomeCats()
        XCTAssertEqual(viewModel.catList.count, 4)
    }
    
    func test_fetchSomeCats_pagination_success() async {
        // Arrange
        let firstPageCats = [Cat.Mock.makeMock(id: "1", name: "Cat 1"), Cat.Mock.makeMock(id: "2", name: "Cat 2")]
        let secondPageCats = [Cat.Mock.makeMock(id: "3", name: "Cat 3"), Cat.Mock.makeMock(id: "4", name: "Cat 4")]
        viewModel = CatsViewModel(service: mockNetworkService)

        // Act
        mockNetworkService.fetchCatsResult = .success(firstPageCats)
        try! await viewModel.fetchSomeCats()
        XCTAssertEqual(viewModel.catList.count, firstPageCats.count)

        mockNetworkService.fetchCatsResult = .success(secondPageCats)
        try! await viewModel.load(currentCat: firstPageCats.last!)

        XCTAssertEqual(viewModel.catList.count, 4)
        XCTAssertEqual(viewModel.catList.last, secondPageCats.last)
    }
    
    func test_fetchSomeCats_failure() async {
        // Arrange
        viewModel = CatsViewModel(service: mockNetworkService)
        mockNetworkService.fetchCatsResult = .failure(.failedToDecode)
        
        // Act
        try! await viewModel.fetchSomeCats()
        
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
        viewModel = CatsViewModel(service: mockNetworkService)
        
        // Act
        viewModel.catList = [cat1, cat2]
        viewModel.searchText = "Bengal"
        
        // Assert
        XCTAssertEqual(viewModel.filteredCats, [cat1])
    }
}
