//
//  String+Extension.swift
//  CatChallenge
//
//  Created by goncaloalmeida on 03/06/2024.
//

import Foundation

extension String {
    func localizableString() -> String {
        NSLocalizedString(self, comment: "")
    }
    
    static func customAttributedString(textOne: String, textTwo: String, size: CGFloat = 16) -> AttributedString {
        var stringOne = AttributedString(textOne)
        stringOne.font = .systemFont(ofSize: size, weight: .bold)
        
        var stringTwo = AttributedString(textTwo)
        stringTwo.font = .systemFont(ofSize: size)
        
        return stringOne + stringTwo
    }
}
