//
//  CoreDataProvider.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/18.
//

import CoreData
import Foundation

final class CoreDataProvider {
    
    static let shared = CoreDataProvider()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
                fatalError()
            }
        }
        
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func create(entityName: String, model: Model) throws {
        let savingContext = self.context
        let entity = NSEntityDescription.entity(
            forEntityName: entityName,
            in: savingContext)
        
        if let entity = entity {
            let object = NSManagedObject(
                entity: entity,
                insertInto: savingContext)
            model.toDictionary().forEach { (key, value) in
                object.setValue(value, forKey: key)
            }
        }
        
        try self.saveContext()
    }
    
    func fetch<T: NSManagedObject>(
        request: NSFetchRequest<T>,
        predicate: NSPredicate? = nil
    ) throws -> [T] {
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        do {
            return try self.context.fetch(request)
        } catch {
            let nsError = error as NSError
            print(error.localizedDescription)
            throw CoreDataProviderError.fetchError(nsError)
        }
    }
    
    func update(object: NSManagedObject, to newObject: Model) throws {
        newObject.toDictionary().forEach { (key, value) in
            object.setValue(value, forKey: key)
        }
        
        try self.saveContext()
    }
    
    func delete(object: NSManagedObject) throws {
        context.delete(object)
        
        try self.saveContext()
    }
    
    func deleteAll<T: NSManagedObject>(request: NSFetchRequest<T>) throws {
        let request: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try self.context.execute(delete)
        } catch {
            let nsError = error as NSError
            print(error.localizedDescription)
            throw CoreDataProviderError.deleteError(nsError)
        }
    }
    
    private func saveContext() throws {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
                let nsError = error as NSError
                print(error.localizedDescription)
                throw CoreDataProviderError.saveError(nsError)
            }
        }
    }
    
}

protocol Model {
    
    func toDictionary() -> [String: Any]
    
}
