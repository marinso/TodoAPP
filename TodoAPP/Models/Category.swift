//
//  Category.swift
//  TodoAPP
//
//  Created by Martin Nasierowski on 05/06/2020.
//  Copyright © 2020 Martin Nasierowski. All rights reserved.
//

import Foundation

enum Category: Int, CustomStringConvertible, CaseIterable {
    case work
    case shopping
    case other
    
    var description: String {
        switch self {
        case .work:
            return "Work"
        case .shopping:
             return "Shopping"
        case .other:
            return "Other"
        }
    }
}
