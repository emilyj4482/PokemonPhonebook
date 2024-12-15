//
//  NetworkService.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import Foundation

enum NetworkError: Error {
    case loadingData
    case decoding
    case response
    
    var localizedDescription: String {
        switch self {
        case .loadingData:
            return "Failed loading data"
        case .decoding:
            return "Failed decoding data"
        case .response:
            return "Failed getting response"
        }
    }
}

protocol NetworkServiceType {
    func requestData<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkService: NetworkServiceType {
    func requestData<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else {
                return completion(.failure(.loadingData))
            }
            
            let successRange = 200..<300
            
            if
                let response = response as? HTTPURLResponse,
                successRange.contains(response.statusCode) {
                guard let decodeData = try? JSONDecoder().decode(T.self, from: data) else {
                    return completion(.failure(.decoding))
                }
                
                return completion(.success(decodeData))
            } else {
                return completion(.failure(.response))
            }
        }.resume()
    }
}
