//
//  CatListView.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import SwiftUI

struct CatListView: View {
    @ObservedObject var viewModel: CatsViewModel
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.filteredCats) { cat in
                    NavigationLink(destination: CatDetailsView(viewModel: viewModel, cat: cat)) {
                        CatView(viewModel: viewModel, cat: cat)
                            .onAppear {
                                viewModel.load(currentCat: cat)
                            }
                    }
                }
            }
        }
        .navigationTitle(LocalizableKeys.Navigation.navCatListTitle)
        .searchable(text: $viewModel.searchText, prompt: LocalizableKeys.SearchBar.placeholder)
        .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
            Button(LocalizableKeys.Alert.button) {
                viewModel.fetchSomeCats()
            }
        }
    }
}


struct CatListView_Previews: PreviewProvider {
    static var previews: some View {
        CatListView(viewModel: CatsViewModel())
    }
}
