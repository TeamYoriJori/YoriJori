//
//  DefaultRecipeBookRepository.swift
//  YoriJori
//
//  Created by forest on 2023/08/03.
//

import Foundation

final class DefaultRecipeBookRepository: RecipeBookRepositoryProtocol {
    let coreDataProvider: CoreDataProvider
    
    init(coreDataProvider: CoreDataProvider = CoreDataProvider.shared) {
        self.coreDataProvider = coreDataProvider
    }
    
    func fetchAllRecipeBooks() throws -> [RecipeBook] {
        let request = CDRecipeBook.fetchRequest()
        let result = try coreDataProvider.fetch(request: request)
        
        return result.map { $0.toDomain() }
    }
    
    func fetchAllRecipeBooks(by sorts: [RecipeBookSortDescriptor : Bool]) throws -> [RecipeBook] {
        let request = CDRecipeBook.fetchRequest()
        
        let result = try coreDataProvider.fetch(
            request: request,
            predicate: nil,
            sortDiscriptors: createSortDescriptor(with: sorts)
        )
        
        return result.map { $0.toDomain() }
    }
    
    func fetchRecipeBookByID(_ id: UUID) throws -> RecipeBook? {
        let request = CDRecipeBook.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        let result = try coreDataProvider.fetch(
            request: request,
            predicate: predicate
        )
        
        return result.first?.toDomain()
    }
    
    func fetchRecipeBooksByTitle(_ title: String, sorts: [RecipeBookSortDescriptor : Bool]) throws -> [RecipeBook] {
        let request = CDRecipeBook.fetchRequest()
        let predicate = NSPredicate(format: "title contains[cd] %@", title)
        
        let result = try coreDataProvider.fetch(
            request: request,
            predicate: predicate,
            sortDiscriptors: createSortDescriptor(with: sorts)
        )
        
        return result.map { $0.toDomain() }
    }
    
    func createRecipeBook(_ model: RecipeBook) throws {
        let recipeBook = CDRecipeBook(context: self.coreDataProvider.context)
        recipeBook.id = model.id
        recipeBook.title = model.title
        recipeBook.image = model.image
        recipeBook.updatedAt = model.updatedAt
        
        recipeBook.addToRecipes(
            NSSet(
                array: model.recipes?.map {
                    $0.toEntity(coreDataProvider: coreDataProvider) } ?? [])
        )
        
        try? self.coreDataProvider.context.save()
    }
    
    func updateRecipeBook(_ recipeBook: RecipeBook) throws {
        let request = CDRecipeBook.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", recipeBook.id as CVarArg)
        guard let recipeBookEntity = try? coreDataProvider.fetch(
            request: request,
            predicate: predicate)
            .first else {
            return
        }
        
        recipeBookEntity.title = recipeBook.title
        recipeBookEntity.image = recipeBook.image
        recipeBookEntity.updatedAt = Date()
        
        recipeBookEntity.recipes = NSSet(
            array: recipeBook.recipes?.compactMap {
                $0.toEntity(coreDataProvider: coreDataProvider) } ?? []
        )
        
        try self.coreDataProvider.context.save()
    }
    
    func deleteRecipeBook(_ recipeBook: RecipeBook) throws {
        let request = CDRecipeBook.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", recipeBook.id as CVarArg)
        guard let recipeEntity = try? coreDataProvider.fetch(
            request: request,
            predicate: predicate).first else {
            return
        }
        
        try self.coreDataProvider.delete(object: recipeEntity)
    }
    
    private func createSortDescriptor(
        with sortDescriptors: [RecipeBookSortDescriptor: Bool]
    ) -> [NSSortDescriptor]
    {
        return sortDescriptors.map { (key: RecipeBookSortDescriptor, value: Bool) in
            NSSortDescriptor(key: key.rawValue, ascending: value)
        }
    }
}
