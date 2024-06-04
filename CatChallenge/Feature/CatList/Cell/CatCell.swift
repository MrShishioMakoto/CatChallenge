//
//  CatCell.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import SwiftUI

struct CatCell: View {
    let cat: Cat
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                if let imageURL = cat.image?.url {
                    AsyncImage(url: URL(string: imageURL)) { res in
                        switch res {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                        case .failure:
                            Image(systemName: Constants.SystemImage.photo)
                        @unknown default:
                            Image(systemName: Constants.SystemImage.photo)
                        }
                    }
                    .frame(width: 100, height: 100)
                } else {
                    Rectangle()
                        .frame(width: 100, height: 100)
                        .overlay(
                            Image(systemName: Constants.SystemImage.photo)
                                .foregroundColor(.gray)
                        )
                }
            }
            Text(cat.name)
                .foregroundColor(.black)
                .font(.caption)
                .padding(.bottom, 4)
        }
    }
}

struct CatCell_Previews: PreviewProvider {
    static var previews: some View {
        CatCell(cat: Cat.dummyData)
    }
}
