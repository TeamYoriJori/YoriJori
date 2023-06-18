//
//  CoreDataProviderError.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/18.
//

import Foundation

enum CoreDataProviderError: Error {
    
    case fetchError(NSError)
    case saveError(NSError)
    case deleteError(NSError)
    
}
