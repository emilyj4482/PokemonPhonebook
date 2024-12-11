//
//  +UIImage.swift
//  PokemonPhonebook
//
//  Created by EMILY on 11/12/2024.
//

import UIKit

extension UIImage {
    var toData: Data? {
        return self.pngData()
    }
}

extension Data {
    var toUIImage: UIImage? {
        return UIImage(data: self)
    }
}
