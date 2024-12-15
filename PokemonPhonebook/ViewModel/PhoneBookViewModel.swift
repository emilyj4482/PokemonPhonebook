//
//  PhoneBookViewModel.swift
//  PokemonPhonebook
//
//  Created by EMILY on 09/12/2024.
//

import Foundation

class PhoneBookViewModel {
    private let coreDataManager = CoreDataManager.shared

    /// controller로부터 데이터 변동이 있는 PhoneBook 정보를 받아 CoreDataManager에 전달해준다
    /// 데이터 변동이 발생할 때마다 NotificationCenter를 통해 MainListViewModel에게 알려주어 업데이트 된 데이터를 fetch할 수 있게 한다
    
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
