//
//  NetworkService.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import Foundation
import Alamofire

class NetworkService {
    private func requestData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    func fetchPokemon(_ id: Int) {
        var urlCompoments = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(id)")
        
        guard let url = urlCompoments?.url else {
            // TODO: throw error
            return
        }
        
    }
}
