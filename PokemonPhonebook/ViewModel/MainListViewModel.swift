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
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: Notification.contextUpdated, object: nil)
    }
    
    @objc func fetchData() {
        phoneBooks = coreDataManager.fetchData()
    }
}
