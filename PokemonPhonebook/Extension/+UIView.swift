//
//  +UIView.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

extension UIView {
    func addSubViews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
