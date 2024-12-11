//
//  PhoneBook.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

struct PhoneBook {
    let id = UUID()
    var name: String
    var phoneNumber: String
    var randomImage: UIImage = UIImage.pokemonball
}
