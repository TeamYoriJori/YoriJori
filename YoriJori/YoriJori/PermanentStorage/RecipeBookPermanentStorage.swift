//
//  RecipeBookPermanentStorage.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/24.
//

import CoreData
import Foundation

final class RecipeBookPermanentStorage {
    
    private let provider = CoreDataProvider.shared
    private let entityName = String(describing: RecipeBook.self)
    
    func create(_ recipeBook: RecipeBook) throws {
        try provider.create(entityName: entityName, model: recipeBook)
    }
    
    func fetchAll() throws-> [CDRecipeBook] {
        try provider.fetch(request: CDRecipeBook.fetchRequest())
    }
    
    func fetch(
        filterdBy predicate: NSPredicate? = nil,
        sortedBy sortDiscriptors: [NSSortDescriptor]? = nil
    ) throws -> [CDRecipeBook]
    {
        try provider.fetch(
            request: CDRecipeBook.fetchRequest(),
            predicate: predicate,
            sortDiscriptors: sortDiscriptors
        )
    }
    
    // TODO: - CD타입 id의 타입 String으로 변경
    func updateInformation(_ recipeBook: RecipeBook) throws {
        let predicate = NSPredicate(format: "id == %Q", recipeBook.id as CVarArg)
        let fetchRequest = CDRecipeBook.fetchRequest()
        fetchRequest.predicate = predicate
        
        guard let object = try provider.fetch(request: fetchRequest).first else {
            throw RecipeBookPermanentStorageError.fetchError
        }
        
        try provider.update(object: object, to: recipeBook)
    }
    
    
    
}

enum RecipeBookPermanentStorageError: Error {
    
    case fetchError
}
