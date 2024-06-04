//
//  CatListView.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import SwiftUI

struct CatListView: View {
    @ObservedObject var viewModel: CatListViewModel
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.filteredCats) { cat in
                        NavigationLink(destination: CatDetailsView(cat: cat)) {
                            CatCell(cat: cat)
                            .onAppear {
                                if cat.id == viewModel.catList.last?.id {
                                    viewModel.fetchSomeCats()
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchSomeCats()
            }
            .navigationTitle(LocalizableKeys.Navigation.navigationTitle)
            .searchable(text: $viewModel.searchText, prompt: LocalizableKeys.SearchBar.placeholder)
    }
}


struct CatListView_Previews: PreviewProvider {
    static var previews: some View {
        CatListView(viewModel: CatListViewModel())
    }
}
