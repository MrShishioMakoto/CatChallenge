//
//  Cat.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import Foundation

struct Cat: Codable, Equatable, Identifiable {
    let id: String
    let name: String
    let origin: String
    let temperament: String
    let description: String
    let lifeSpan: String
    let image: Image?
    
    enum CodingKeys: String, CodingKey {
        case id, name, origin, temperament, description, image
        case lifeSpan = "life_span"
    }
    
    struct Image: Codable, Equatable {
        let id: String?
        let url: String?
        
        enum CodingKeys: String, CodingKey {
            case id, url
        }
    }
    
    static func == (lhs: Cat, rhs: Cat) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.origin == rhs.origin &&
        lhs.temperament == rhs.temperament &&
        lhs.description == rhs.description &&
        lhs.lifeSpan == rhs.lifeSpan &&
        lhs.image == rhs.image
    }
    
    init(
        id: String,
        name: String,
        origin: String,
        temperament: String,
        description: String,
        lifeSpan: String,
        image: Image
    ) {
        self.id = id
        self.name = name
        self.origin = origin
        self.temperament = temperament
        self.description = description
        self.lifeSpan = lifeSpan
        self.image = image
    }
    
    init(favCat: FavouriteCatsEntity) {
        id = favCat.id ?? ""
        name = favCat.name ?? ""
        origin = favCat.origin ?? ""
        temperament = favCat.temperament ?? ""
        description = favCat.desc ?? ""
        lifeSpan = favCat.lifeSpan ?? ""
        image = Image(id: favCat.id, url: favCat.imageURL ?? "")
    }
}

extension Cat {
    static let dummyData = Cat(id: "abys", name: "Abyssinian", origin: "Egypt", temperament: "Active, Energetic", description: "The Abyssinian is easy to care for, and a joy to have in your home.", lifeSpan: "9 - 15", image: Image(id: "0XYvRd7oD", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"))
}
