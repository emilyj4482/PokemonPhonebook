//
//  CoreDataManager.swift
//  PokemonPhonebook
//
//  Created by EMILY on 11/12/2024.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    var context: NSManagedObjectContext
    
    private init() {
        let container = NSPersistentContainer(name: CDKey.container.rawValue)
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        context = container.viewContext
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
    
    func fetchData() -> [PhoneBook] {
        let request = NSFetchRequest<PhoneBookEntity>(entityName: CDKey.entity.rawValue)
        do {
            let entites = try context.fetch(request)
            return entites.compactMap { $0.toStruct() }.sorted { $0.name < $1.name }
        } catch {
            print("Failed fetching context")
            return []
        }
    }
    
    func addData(_ phoneBook: PhoneBook) {
        _ = phoneBook.toEntity(in: context)
        saveData()
    }
    
    func updateData(_ phoneBook: PhoneBook) {
        let request = NSFetchRequest<PhoneBookEntity>(entityName: CDKey.entity.rawValue)
        request.predicate = NSPredicate(format: "id == %@", phoneBook.id as CVarArg)
        
        do {
            let result = try context.fetch(request)
            for data in result as [NSManagedObject] {
                data.setValue(phoneBook.name, forKey: CDKey.name.rawValue)
                data.setValue(phoneBook.phoneNumber, forKey: CDKey.phoneNumber.rawValue)
                data.setValue(phoneBook.randomImage.toData, forKey: CDKey.randomImage.rawValue)
            }
            saveData()
        } catch {
            print("Failed updating context")
        }
    }
    
    func deleteData(of id: UUID) {
        let request = NSFetchRequest<PhoneBookEntity>(entityName: CDKey.entity.rawValue)
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let result = try context.fetch(request)
            for data in result as [NSManagedObject] {
                context.delete(data)
            }
            saveData()
        } catch {
            print("Failed deleting context")
        }
    }
}

extension PhoneBook {
    func toEntity(in context: NSManagedObjectContext) -> PhoneBookEntity {
        let entity = PhoneBookEntity(context: context)
        entity.id = self.id
        entity.name = self.name
        entity.phoneNumber = self.phoneNumber
        entity.randomImage = self.randomImage.toData
        return entity
    }
}
