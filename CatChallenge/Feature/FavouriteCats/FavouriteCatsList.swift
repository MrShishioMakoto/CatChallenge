//
//  FavouriteCatsList.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 04/06/2024.
//

import SwiftUI

struct FavouriteCatsList: View {
    @ObservedObject var viewModel: CatsViewModel
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.favouriteCats, id: \.id) { favCat in
                    NavigationLink(destination: CatDetailsView(viewModel: viewModel, cat: Cat(favCat: favCat))) {
                        CatView(viewModel: viewModel, cat: Cat(favCat: favCat), screenType: .favourites)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchSomeCats()
        }
        .navigationTitle(LocalizableKeys.Navigation.navFavCatListTitle)
    }
}

struct FavouriteCatsList_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteCatsList(viewModel: CatsViewModel())
    }
}
