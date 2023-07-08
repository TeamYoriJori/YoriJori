//
//  CDIngredient+CoreDataProperties.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/19.
//
//

import Foundation
import CoreData


extension CDIngredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDIngredient> {
        return NSFetchRequest<CDIngredient>(entityName: "CDIngredient")
    }

    @NSManaged public var title: String?
    @NSManaged public var amount: Int64
    @NSManaged public var unit: String?

}

extension CDIngredient : Identifiable {

}
