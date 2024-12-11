//
//  PhoneBookManager.swift
//  PokemonPhonebook
//
//  Created by EMILY on 11/12/2024.
//

import UIKit

class PhoneBookManager {
    static let shared = PhoneBookManager()
    
    @Published var phoneBooks: [PhoneBook] = [
        PhoneBook(name: "파이리", phoneNumber: "010-9876-5432", randomImage: UIImage.pokemonball),
        PhoneBook(name: "꼬부기", phoneNumber: "010-1234-5678", randomImage: UIImage.pokemonball),
        PhoneBook(name: "이상해씨", phoneNumber: "010-3645-4567", randomImage: UIImage.pokemonball),
    ]
}
