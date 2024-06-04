//
//  FavouriteCatsList.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 04/06/2024.
//

import SwiftUI

struct FavouriteCatsList: View {
    @ObservedObject var viewModel: CatListViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct FavouriteCatsList_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteCatsList(viewModel: CatListViewModel())
    }
}
