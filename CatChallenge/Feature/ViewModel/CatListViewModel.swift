//
//  CatListViewModel.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import Foundation
import Combine

@MainActor
class CatListViewModel: ObservableObject {
    @Published var catList: [Cat] = []
    @Published var searchText: String = ""
    @Published var errorMessage: String?
    
    private let service: NetworkServiceProtocol
    
    private let limit = 20
    private var page = -1
    
    var filteredCats: [Cat] {
        guard !searchText.isEmpty else { return catList }
        return catList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
    
    func fetchSomeCats() {
        Task {
            do {
                page += 1
                let cats = try await service.fetchCats(page: page, limit: limit)
                self.catList.append(contentsOf: cats)
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
