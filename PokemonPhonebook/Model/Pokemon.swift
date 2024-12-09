//
//  Pokemon.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let sprites: PokemonImage
}

struct PokemonImage: Decodable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "front_default"
    }
}
