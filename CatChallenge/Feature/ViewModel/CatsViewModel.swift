//
//  CatsViewModel.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import Foundation
import Combine
import CoreData

@MainActor
class CatsViewModel: ObservableObject {
    @Published var catList: [Cat] = []
    @Published var favouriteCats: [FavouriteCatsEntity] = []
    @Published var searchText: String = ""
    @Published var error: CustomError?
    @Published var hasError = false
    
    private let service: NetworkServiceProtocol
    private let dataPersistenceController = DataPersistenceController.shared
    
    private let limit = 20
    private var page = 0
    
    var filteredCats: [Cat] {
        guard !searchText.isEmpty else { return catList }
        return catList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
        fetchSomeCats()
        fetchFavouriteCats()
    }
    
    //MARK: - API Call
    func load(currentCat cat: Cat) {
        if cat.id == catList.last?.id {
            page += 1
            self.fetchSomeCats()
        }
    }
    
    func fetchSomeCats() {
        Task {
            do {
                let cats = try await service.fetchCats(page: page, limit: limit)
                self.catList.append(contentsOf: cats)
            } catch let err {
                self.hasError = true
                self.error = err as? CustomError
            }
        }
    }
    
    //MARK: - CoreData
    func fetchFavouriteCats() {
        let request = NSFetchRequest<FavouriteCatsEntity>(entityName: Constants.Entity.favouriteCats)
        do {
            favouriteCats = try dataPersistenceController.container.viewContext.fetch(request)
        } catch let err {
            self.hasError = true
            self.error = CustomError.custom(error: err)
        }
    }
    
    private func addFavouriteCat(cat: Cat) {
        let newCat = FavouriteCatsEntity(context: dataPersistenceController.container.viewContext)
        newCat.name = cat.name
        newCat.id = cat.id
        newCat.origin = cat.origin
        newCat.temperament = cat.temperament
        newCat.desc = cat.description
        newCat.imageURL = cat.image?.url
        newCat.lifeSpan = cat.lifeSpan
        favouriteCats.append(newCat)
        dataPersistenceController.saveData()
    }
    
    private func removeFavouriteCat(cat: Cat) {
        if let index = favouriteCats.firstIndex(where: { $0.id == cat.id }) {
            dataPersistenceController.container.viewContext.delete(favouriteCats[index])
            favouriteCats.remove(at: index)
            dataPersistenceController.saveData()
        }
    }
    
    func updateFavourite(cat: Cat) {
        guard isFavourite(cat: cat) else {
            addFavouriteCat(cat: cat)
            return
        }
        removeFavouriteCat(cat: cat)
    }
    
    func isFavourite(cat: Cat) -> Bool {
        favouriteCats.contains(where: { $0.id == cat.id })
    }
}
