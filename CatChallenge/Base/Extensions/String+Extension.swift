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
}
