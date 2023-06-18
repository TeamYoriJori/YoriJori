//
//  PermanentStorageManager.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/17.
//

import Foundation

protocol PermanentStorageManager {
    
    func create<T>(entity: T) throws -> Void
    func fetch<T>(identifier: UUID) throws -> T?
    func fetchAll<T>() throws -> [T]
    func fetchAll<T>(by:[Condition]) throws -> [T]
    func fetchAll<T>(sortedBy: [Criteria]) throws -> [T]
    func update<T>(entity: T) throws -> Void
    func delete<T>(entity: T) throws -> Void
    func deleteAll<T>(entityType: T) throws -> Void
    
}

protocol Condition {}

protocol Criteria {}
