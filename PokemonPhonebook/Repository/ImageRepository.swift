//
//  ImageRepository.swift
//  PokemonPhonebook
//
//  Created by EMILY on 15/12/2024.
//

import UIKit

class ImageRepository {
    
    private let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchPokemon(completion: @escaping (UIImage?) -> Void) {
        let randomId = Int.random(in: 0...1000)
        let urlCompoments = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(randomId)")
        guard let url = urlCompoments?.url else { return }
        
        networkService.requestData(url: url) { [weak self] (result: Result<Pokemon, NetworkError>) in
            switch result {
            case .success(let pokemon):
                guard let imageURL = URL(string: pokemon.image.imageURL) else {
                    completion(nil)
                    return
                }
                self?.downloadImage(from: imageURL, completion: completion)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if
                let imageData = try? Data(contentsOf: url),
                let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
