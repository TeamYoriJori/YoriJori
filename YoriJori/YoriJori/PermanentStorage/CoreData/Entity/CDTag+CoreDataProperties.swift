//
//  CDTag+CoreDataProperties.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/19.
//
//

import Foundation
import CoreData


extension CDTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTag> {
        return NSFetchRequest<CDTag>(entityName: "CDTag")
    }

    @NSManaged public var title: String
    @NSManaged public var recipes: CDRecipe?

}

extension CDTag : Identifiable {

}

extension CDTag {
    func toDomain() -> Tag {
        return Tag(name: self.title)
    }
}
