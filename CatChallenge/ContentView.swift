//
//  ContentView.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CatsViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                CatListView(viewModel: viewModel)
            }
            .tabItem {
                Label(LocalizableKeys.TabItem.list,
                      systemImage: Constants.SystemImage.listBullet)
            }
            NavigationView {
                FavouriteCatsList(viewModel: viewModel)
            }
            .tabItem {
                Label(LocalizableKeys.TabItem.favourites, systemImage: Constants.SystemImage.starFill)
            }
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
