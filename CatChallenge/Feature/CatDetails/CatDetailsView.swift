//
//  CatDetailsView.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import SwiftUI

struct CatDetailsView: View {
    @ObservedObject var viewModel: CatsViewModel
    let cat: Cat
    
    var body: some View {
        VStack {
            HStack {
                Text(String.customAttributedString(textOne: LocalizableKeys.CatDetails.breed, textTwo: cat.name, size: 24))
                
                Spacer()
                
                FavouriteButton(isFavourite: viewModel.isFavourite(cat: cat)) {
                    viewModel.updateFavourite(cat: cat)
                }
                .frame(width: 24, height: 24)
                .foregroundColor(.black)
            }
            .padding()
            
            CatImage(imageUrl: cat.image?.url)
                .frame(width: 200, height: 200)
                .padding()
            
            Text(String.customAttributedString(textOne: LocalizableKeys.CatDetails.origin, textTwo: cat.origin))
                .padding(2)
            
            Text(String.customAttributedString(textOne: LocalizableKeys.CatDetails.temperament, textTwo: cat.temperament))
                .padding(2)
            
            Text(String.customAttributedString(textOne: LocalizableKeys.CatDetails.description, textTwo: cat.description))
                .padding(2)
            
            Spacer()
        }
        .padding()
    }
}

struct CatDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CatDetailsView(viewModel: CatsViewModel(), cat: Cat.dummyData)
    }
}
