//
//  CatView.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import SwiftUI

struct CatView: View {
    enum ScreenType {
        case list, favourites
    }
    
    @ObservedObject var viewModel: CatsViewModel
    let cat: Cat
    let screenType: ScreenType
    
    init(viewModel: CatsViewModel, cat: Cat, screenType: ScreenType = .list) {
        self.viewModel = viewModel
        self.cat = cat
        self.screenType = screenType
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                CatImage(imageUrl: cat.image?.url)
                    .frame(width: 100, height: 100)
                
                FavouriteButton(isFavourite: viewModel.isFavourite(cat: cat)) {
                    viewModel.updateFavourite(cat: cat)
                }
                .frame(width: 24, height: 24)
                .foregroundColor(.black)
                .padding(.top, -50)
            }
            
            Text(screenType == .list ? cat.name : cat.lifeSpan)
                .foregroundColor(.black)
                .font(.caption)
                .padding(.bottom, 4)
        }
    }
}

struct CatCell_Previews: PreviewProvider {
    static var previews: some View {
        CatView(viewModel: CatsViewModel(), cat: Cat.dummyData)
    }
}
