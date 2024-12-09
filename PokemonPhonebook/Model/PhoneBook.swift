//
//  PhoneBook.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import Foundation

struct PhoneBook {
    var imageURL: String
    var name: String
    var phoneNumber: String
    
    static let dummy = PhoneBook(imageURL: "pikachu", name: "피카츄", phoneNumber: "010-1234-5678")
}
