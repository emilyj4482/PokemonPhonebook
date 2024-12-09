//
//  PhoneBookViewModel.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit
import Alamofire

protocol PhoneBookViewDelegate: AnyObject {
    func bindImage(_ image: UIImage)
}

class PhoneBookViewModel {
    
    weak var delegate: PhoneBookViewDelegate?
    
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
                
                guard let imageURL = URL(string: pokemon.sprites.imageURL) else { return }
                AF.request(imageURL).responseData { response in
                    if let data = response.data, let image = UIImage(data: data) {
                        DispatchQueue.main.async { [weak self] in
                            self?.delegate?.bindImage(image)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
