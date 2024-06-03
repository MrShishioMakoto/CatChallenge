//
//  Cat.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import Foundation

struct Cat: Codable, Identifiable {
    let id: String?
    let name: String?
    let origin: String?
    let temperament: String?
    let description: String?
    let image: Image?
    
    enum CodingKeys: String, CodingKey {
        case id, name, origin, temperament, description, image
    }
    
    struct Image: Codable {
        let id: String?
        let url: String?
        
        enum CodingKeys: String, CodingKey {
            case id, url
        }
    }
}

extension Cat {
    static let dummyData = Cat(id: "abys", name: "Abyssinian", origin: "Egypt", temperament: "Active, Energetic", description: "The Abyssinian is easy to care for, and a joy to have in your home.", image: Image(id: "0XYvRd7oD", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"))
}
