//
//  Tag+DTO.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/07/08.
//

import CoreData
import Foundation

extension CDTag {
    func toDomain() -> Tag {
        return Tag(name: self.name)
    }
}

extension Tag {
    func toEntity(context: NSManagedObjectContext) throws -> CDTag {
        let request = CDTag.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", self.name)
        let fetchedTags = try CoreDataProvider.shared.fetch(request: request)

        if let fetchedTag = fetchedTags.first {
            return fetchedTag
        }
       
        let tag = CDTag(context: context)
        tag.name = self.name
        return tag
    }
}
