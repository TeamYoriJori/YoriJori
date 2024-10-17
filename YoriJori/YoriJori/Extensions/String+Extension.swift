//
//  String+Extension.swift
//  YoriJori
//
//  Created by 예지 on 10/9/24.
//

import Foundation

extension String {
    
    static let empty = String()
    
    var lineBreakByCharWrapping: Self {
      self.map({ String($0) }).joined(separator: "\u{200B}")
    }
    
}
