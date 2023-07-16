//
//  Grocery+DTO.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/07/08.
//

import CoreData
import Foundation

extension CDGrocery {
    func toDomain() -> Grocery {
        return Grocery(name: self.name)
    }
}

extension Grocery {
    func toEntity(coreDataProvider: CoreDataProvider) throws -> CDGrocery {
        let request = CDGrocery.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", self.name)
        let fetchedGroceries = try coreDataProvider.fetch(request: request)

        if let fetchedGrocery = fetchedGroceries.first {
            return fetchedGrocery
        }
       
        let grocery = CDGrocery(context: coreDataProvider.context)
        grocery.name = self.name
        return grocery
    }
}
