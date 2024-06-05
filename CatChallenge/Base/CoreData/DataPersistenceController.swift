//
//  DataPersistenceController.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 04/06/2024.
//

import CoreData

struct DataPersistenceController {
    static let shared = DataPersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FavouriteCatsData")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}
