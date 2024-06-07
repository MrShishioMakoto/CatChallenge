//
//  Cat+Mock.swift
//  CatChallengeTests
//
//  Created by goncaloalmeida on 06/06/2024.
//

@testable import CatChallenge
import SwiftUI

extension Cat {
    enum Mock {
        static func makeMock(
            id: String = "abys",
            name: String = "Abyssinian",
            origin: String = "Egypt",
            temperament: String = "Active, Energetic, Independent, Intelligent, Gentle",
            description: String = "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
            lifeSpan: String = "14 - 15",
            image: Image? = Image(
                id: "0XYvRd7oD",
                url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")
        ) -> Cat {
            return Cat(
                id: id,
                name: name,
                origin: origin,
                temperament: temperament,
                description: description,
                lifeSpan: lifeSpan,
                image: image ?? Image(id: "0XYvRd7oD",
                                      url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")
            )
        }
    }
}

