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
    func toEntity(context: NSManagedObjectContext) throws -> CDGrocery {
        let request = CDGrocery.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", self.name)
        let fetchedGroceries = try CoreDataProvider.shared.fetch(request: request)

        if let fetchedGrocery = fetchedGroceries.first {
            return fetchedGrocery
        }
       
        let grocery = CDGrocery(context: context)
        grocery.name = self.name
        return grocery
    }
}
