//
//  +UIImageView.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

extension UIImageView {
    func setImageViewRounded() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
}
