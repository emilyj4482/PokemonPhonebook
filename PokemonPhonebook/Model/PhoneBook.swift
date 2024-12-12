//
//  PhoneBook.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit

struct PhoneBook {
    let id: UUID
    var name: String
    var phoneNumber: String
    var randomImage: UIImage = UIImage.pokemonball
}

/// PhoneBookEntity를 구조체 형태로 전환하는 extension
extension PhoneBookEntity {
    func toStruct() -> PhoneBook? {
        guard
            let id = self.id,
            let name = self.name,
            let phoneNumber = self.phoneNumber,
            let randomImage = self.randomImage?.toUIImage
        else { return nil }
        return PhoneBook(id: id, name: name, phoneNumber: phoneNumber, randomImage: randomImage)
    }
}
