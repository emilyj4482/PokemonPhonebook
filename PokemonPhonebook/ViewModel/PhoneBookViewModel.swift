//
//  PhoneBookViewModel.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import UIKit
import Alamofire

protocol ImageBindingDelegate: AnyObject {
    func bindImage(_ image: UIImage)
}

class PhoneBookViewModel {
    // delegate : PhoneBookView
    weak var delegate: ImageBindingDelegate?
    
    private let networkService: NetworkServiceType
    private let coreDataManager = CoreDataManager.shared
    
    init(networkService: NetworkServiceType = NetworkService()) {
        self.networkService = networkService
    }
    
    // 네트워크 통신을 통해 포켓몬 정보를 받아온 뒤 그 중 image url 값을 이용하여 또다시 네트워크 통신을 하여 image를 불러온다
    // 불러온 이미지는 delegate를 통해 PhoneBookView의 이미지 뷰와 바인딩해준다
    func fetchPokemon() {
        let id = Int.random(in: 0...1000)
        let urlCompoments = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(id)")
        guard let url = urlCompoments?.url else { return }
        
        networkService.requestData(url: url) { (result: Result<Pokemon, AFError>) in
            switch result {
            case .success(let pokemon):
                guard let imageURL = URL(string: pokemon.image.imageURL) else { return }
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
    
    /// controller로부터 데이터 변동이 있는 PhoneBook 정보를 받아 CoreDataManager에 전달해준다
    /// 데이터 변동이 발생할 때마다 NotificationCenter를 통해 MainListView에 알려주어 업데이트 된 데이터를 fetch할 수 있게 한다
    
    func addPhoneBook(_ phoneBook: PhoneBook) {
        coreDataManager.addData(phoneBook)
        postNotification()
    }
    
    func updatePhoneBook(_ phoneBook: PhoneBook) {
        coreDataManager.updateData(phoneBook)
        postNotification()
    }
    
    func deletePhoneBook(of id: UUID) {
        coreDataManager.deleteData(of: id)
        postNotification()
    }
    
    func postNotification() {
        NotificationCenter.default.post(name: Notification.contextUpdated, object: nil)
    }
}
