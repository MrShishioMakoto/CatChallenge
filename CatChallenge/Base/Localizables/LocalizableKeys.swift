//
//  LocalizableKeys.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import Foundation

enum LocalizableKeys {
    enum Navigation {
        static let navCatListTitle = "navigation.cat.list.title".localizableString()
        static let navFavCatListTitle = "navigation.fav.cat.list.title".localizableString()
    }
    enum TabItem {
        static let list = "tabItem.list".localizableString()
        static let favourites = "tabItem.favourites".localizableString()
    }
    enum CatDetails {
        static let breed = "details.breedName".localizableString()
        static let origin = "details.origin".localizableString()
        static let temperament = "details.temperament".localizableString()
        static let description = "details.description".localizableString()
    }
    enum NetworkError {
        static let generic = "network.error.invalid.generic".localizableString()
        static let url = "network.error.invalid.url".localizableString()
        static let decode = "network.error.failed.to.decode".localizableString()
        static let invalid = "network.error.invalid.status.code".localizableString()
    }
    enum SearchBar {
        static let placeholder = "search.bar.placeholder".localizableString()
    }
    enum Alert {
        static let button = "alert.button".localizableString()
    }
}
