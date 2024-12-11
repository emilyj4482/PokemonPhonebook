//
//  PhoneBook.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

struct PhoneBook {
    let id: UUID = .init()
    var name: String
    var phoneNumber: String
    var randomImage: UIImage = UIImage.pokemonball
    
    mutating func update(_ phoneBook: PhoneBook) {
        name = phoneBook.name
        phoneNumber = phoneBook.phoneNumber
        randomImage = phoneBook.randomImage
    }
}
