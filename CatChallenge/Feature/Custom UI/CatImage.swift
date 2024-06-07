//
//  CatImage.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 04/06/2024.
//

import SwiftUI

struct CatImage: View {
    var imageUrl: String?
    
    var body: some View {
        if let stringUrl = imageUrl {
            AsyncImage(url: URL(string: stringUrl)) { res in
                switch res {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                default:
                    Image(systemName: Constants.SystemImage.photo)
                }
            }
        } else {
            Rectangle()
                .overlay(
                    Image(systemName: Constants.SystemImage.photo)
                        .resizable()
                        .foregroundColor(.gray)
                )
                .foregroundColor(.clear)
        }
    }
}

struct CatImage_Previews: PreviewProvider {
    static var previews: some View {
        CatImage(imageUrl: "")
    }
}
