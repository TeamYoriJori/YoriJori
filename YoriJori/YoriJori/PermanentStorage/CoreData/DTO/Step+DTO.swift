//
//  Step+DTO.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/07/08.
//

import CoreData
import Foundation

extension CDStep {
    func toDomain() -> Step {
        let groceries = self.groceries?.allObjects as! [CDGrocery]
        return Step(
            index: Int(self.index),
            description: self.descriptions,
            image: self.image,
            time: Int(self.time),
            groceries: groceries.map { $0.toDomain() }
        )
    }
}

extension Step {
    func toEntiy(context: NSManagedObjectContext) -> CDStep {
        let step = CDStep(context: context)
        step.index = Int64(self.index)
        step.descriptions = self.description ?? ""
        step.image = self.image
        step.time = Int64(self.time ?? -1)
        step.groceries = NSSet(
            array: self.groceries?.map { try! $0.toEntity(context: context) } ?? [] )
        return step 
    }
}

