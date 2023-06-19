//
//  CDRecipeBook+CoreDataProperties.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/19.
//
//

import Foundation
import CoreData


extension CDRecipeBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRecipeBook> {
        return NSFetchRequest<CDRecipeBook>(entityName: "CDRecipeBook")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var image: Data?
    @NSManaged public var recipes: CDRecipe?

}

extension CDRecipeBook : Identifiable {

}
