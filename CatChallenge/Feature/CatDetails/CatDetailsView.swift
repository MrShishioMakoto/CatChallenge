//
//  CatDetailsView.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import SwiftUI

struct CatDetailsView: View {
    let cat: Cat
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    Text(LocalizableKeys.CatDetails.breed)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    + Text(cat.name)
                        .font(.system(size: 24))
                } 
                Spacer()
                if cat.isFavourite {
                    Image(systemName: Constants.SystemImage.starFill)
                        .resizable()
                        .frame(width: 24, height: 24)
                } else {
                    Image(systemName: Constants.SystemImage.star)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            .padding()
            
            if let imageURL = cat.image?.url,
               let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 200, height: 200)
                .padding()
            } else {
                Image(systemName: Constants.SystemImage.photo)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray)
            }
            Group {
                Text(LocalizableKeys.CatDetails.origin)
                    .fontWeight(.bold)
                + Text(cat.origin)
            }
            .padding(2)
            Group {
                Text(LocalizableKeys.CatDetails.temperament)
                    .fontWeight(.bold)
                + Text(cat.temperament)
            }
            .padding(2)
            Group {
                Text(LocalizableKeys.CatDetails.description)
                    .fontWeight(.bold)
                + Text(cat.description)
            }
            .padding(2)
            Spacer()
        }
        .padding()
    }
}

struct CatDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CatDetailsView(cat: Cat.dummyData)
    }
}
