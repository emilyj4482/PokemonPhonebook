//
//  MainListViewModel.swift
//  PokemonPhonebook
//
//  Created by EMILY on 10/12/2024.
//

import UIKit
import Combine

class MainListViewModel {
    private let phoneBookManager = PhoneBookManager.shared
    
    var phoneBooks: [PhoneBook] {
        didSet {
            print(phoneBooks)
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.phoneBooks = phoneBookManager.phoneBooks
        phoneBookManager.$phoneBooks.sink { self.phoneBooks = $0 }.store(in: &cancellables)
    }
}
