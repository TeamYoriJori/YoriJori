//
//  CDGrocery+CoreDataProperties.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/25.
//
//

import CoreData
import Foundation


extension CDGrocery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGrocery> {
        return NSFetchRequest<CDGrocery>(entityName: "CDGrocery")
    }

    @NSManaged public var name: String

}

extension CDGrocery : Identifiable {

}

extension CDGrocery {
    func toDomain() -> Grocery {
        return Grocery(name: self.name)
    }
}
