//
//  PhoneBookViewModel.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import Foundation
import Alamofire

class PhoneBookViewModel {
    private let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchPokemon() {
        let id: Int = 1
        
        let urlCompoments = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(id)")
        
        guard let url = urlCompoments?.url else { return }
        
        networkService.requestData(url: url) { (result: Result<Pokemon, AFError>) in
            switch result {
            case .success(let pokemon):
                print(pokemon)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
