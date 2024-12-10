//
//  MainListViewModel.swift
//  PokemonPhonebook
//
//  Created by EMILY on 10/12/2024.
//

import Foundation

class MainListViewModel {
    var phoneBooks: [PhoneBook] = [
        PhoneBook(imageURL: "pokemonball", name: "파이리", phoneNumber: "010-9876-5432"),
        PhoneBook(imageURL: "pokemonball", name: "꼬부기", phoneNumber: "010-1234-5678"),
        PhoneBook(imageURL: "pokemonball", name: "이상해씨", phoneNumber: "010-3645-4567"),
    ]
}
