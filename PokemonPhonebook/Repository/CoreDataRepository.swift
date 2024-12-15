//
//  CoreDataRepository.swift
//  PokemonPhonebook
//
//  Created by EMILY on 15/12/2024.
//

import CoreData

class CoreDataRepository {
    var phoneBooks: [PhoneBookEntity] = []
    
    private let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: CDKey.container.rawValue)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        fetchData()
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveData() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed saving context")
            }
        }
    }
    
    func fetchData() {
        let fetchRequest = NSFetchRequest<PhoneBookEntity>(entityName: CDKey.entity.rawValue)
        
        // 이름순으로 정렬
        let sortDescriptor = NSSortDescriptor(key: CDKey.name.rawValue, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            phoneBooks = try context.fetch(fetchRequest)
        } catch {
            print("Failed fetching context")
        }
    }
    
    func searchData(with id: NSManagedObjectID) -> PhoneBookEntity? {
        do {
            let phoneBook = try context.existingObject(with: id) as? PhoneBookEntity
            return phoneBook
        } catch {
            print("Failed searching object")
            return nil
        }
    }
    
    func addData(_ phoneBook: PhoneBook) {
        _ = phoneBook.createEntity(in: context)
        saveData()
    }
    
    func updateData(with id: NSManagedObjectID, _ phoneBook: PhoneBook) {
        guard let entity = searchData(with: id) else { return }
        phoneBook.updateEntity(entity)
        saveData()
    }
    
    func deleteData(with id: NSManagedObjectID) {
        guard let entity = searchData(with: id) else { return }
        context.delete(entity)
        saveData()
    }
}

extension PhoneBook {
    func createEntity(in context: NSManagedObjectContext) -> PhoneBookEntity {
        let entity = PhoneBookEntity(context: context)
        updateEntity(entity)
        return entity
    }
    
    func updateEntity(_ entity: PhoneBookEntity) {
        entity.name = self.name
        entity.phoneNumber = self.phoneNumber
        entity.randomImage = self.randomImage.pngData()
    }
}
