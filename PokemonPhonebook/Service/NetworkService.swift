//
//  NetworkService.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import Foundation
import Alamofire

protocol NetworkServiceType {
    func requestData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void)
}

class NetworkService: NetworkServiceType {
    func requestData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
}
