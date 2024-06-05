//
//  FavouriteButton.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 04/06/2024.
//

import SwiftUI

struct FavouriteButton: View {
    var isFavourite: Bool
    var onButtonToggle: () -> Void
    var buttonImage: String {
        isFavourite ? Constants.SystemImage.starFill : Constants.SystemImage.star
    }
    
    init(isFavourite: Bool, onButtonToggle: @escaping () -> Void) {
        self.isFavourite = isFavourite
        self.onButtonToggle = onButtonToggle
    }
    
    var body: some View {
        Button(action: {
            onButtonToggle()
        }) {
            Image(systemName: buttonImage)
                .resizable()
        }
    }
}

struct FavouriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteButton(isFavourite: false, onButtonToggle: {})
    }
}
