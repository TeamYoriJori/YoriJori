//
//  DefaultRecipeBookRepository.swift
//  YoriJori
//
//  Created by forest on 2023/08/03.
//

import Foundation

final class DefaultRecipeBookRepository {
    let coreDataProvider: CoreDataProvider
    
    private let defaultRecipeRepository: DefaultRecipeRepository
    
    init(coreDataProvider: CoreDataProvider = CoreDataProvider.shared) {
        self.coreDataProvider = coreDataProvider
        self.defaultRecipeRepository = DefaultRecipeRepository(
            coreDataProvider: coreDataProvider)
    }
    
    func fetchRecipeBookEntity(id: UUID) throws -> CDRecipeBook {
        let request = CDRecipeBook.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let recipeBook = try coreDataProvider.fetch(
            request: request,
            predicate: predicate
        ).first else {
            throw RecipeBookRepositoryError.RecipeBookFetchError
        }
        
        return recipeBook
    }
    
    private func createSortDescriptor(
        with sortDescriptors: [RecipeBookSortDescriptor: Bool]
    ) -> [NSSortDescriptor]
    {
        return sortDescriptors
            .map { (key: RecipeBookSortDescriptor, value: Bool) in
                NSSortDescriptor(key: key.rawValue, ascending: value) }
    }
}

extension DefaultRecipeBookRepository: RecipeBookRepositoryProtocol {
    func fetchAllRecipeBooks() throws -> [RecipeBook] {
        let request = CDRecipeBook.fetchRequest()
        let result = try coreDataProvider.fetch(request: request)
        return result.map { $0.toDomain() }
    }
    
    func fetchAllRecipeBooks(
        by sorts: [RecipeBookSortDescriptor : Bool]
    ) throws -> [RecipeBook]
    {
        let request = CDRecipeBook.fetchRequest()
        let result = try coreDataProvider.fetch(
            request: request,
            predicate: nil,
            sortDiscriptors: createSortDescriptor(with: sorts)
        )
        return result.map { $0.toDomain() }
    }
    
    func fetchRecipeBookByID(_ id: UUID) throws -> RecipeBook? {
        return try fetchRecipeBookEntity(id: id).toDomain()
    }
    
    func fetchRecipeBooksByTitle(
        _ title: String,
        sorts: [RecipeBookSortDescriptor : Bool]
    ) throws -> [RecipeBook]
    {
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
        
        try? self.coreDataProvider.context.save()
    }
    
    func updateRecipeBook(_ recipeBook: RecipeBook) throws {
        let recipeBookEntity = try fetchRecipeBookEntity(id: recipeBook.id)
        recipeBookEntity.title = recipeBook.title
        recipeBookEntity.image = recipeBook.image
        recipeBookEntity.updatedAt = Date()
        
        try self.coreDataProvider.context.save()
    }
    
    func deleteRecipeBook(_ recipeBook: RecipeBook) throws {
        let recipeBookEntity = try fetchRecipeBookEntity(id: recipeBook.id)
        
        try self.coreDataProvider.delete(object: recipeBookEntity)
    }
    
    func addRecipe(_ recipe: Recipe, to recipeBook: RecipeBook) throws {
        let recipeEntity = try defaultRecipeRepository.fetchRecipeEntity(
            id: recipe.id)
        let recipeBookEntity = try fetchRecipeBookEntity(id: recipeBook.id)
        recipeBookEntity.addToRecipes(recipeEntity)
        
        try self.coreDataProvider.context.save()
    }
    
    func removeRecipe(_ recipe: Recipe, from recipeBook: RecipeBook) throws {
        let recipeEntity = try defaultRecipeRepository.fetchRecipeEntity(
            id: recipe.id)
        let recipeBookEntity = try fetchRecipeBookEntity(id: recipeBook.id)
        recipeBookEntity.removeFromRecipes(recipeEntity)
        
        try self.coreDataProvider.context.save()
    }
}
