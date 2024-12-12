//
//  MainListViewModel.swift
//  PokemonPhonebook
//
//  Created by EMILY on 10/12/2024.
//

import UIKit

class MainListViewModel {
    private let coreDataManager = CoreDataManager.shared
    
    var phoneBooks: [PhoneBook]
    
    init() {
        self.phoneBooks = coreDataManager.fetchData()
        // 데이터 변동이 발생할 때마다 coredata context로부터 새로 데이터를 받아오기 위해 observing
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: Notification.contextUpdated, object: nil)
    }
    
    @objc func fetchData() {
        phoneBooks = coreDataManager.fetchData()
    }
}
