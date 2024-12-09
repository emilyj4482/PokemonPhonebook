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
    let image: PokemonImage
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case image = "sprites"
    }
}

struct PokemonImage: Decodable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "front_default"
    }
}
